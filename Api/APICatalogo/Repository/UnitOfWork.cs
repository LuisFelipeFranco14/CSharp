﻿using APICatalogo.Context;

namespace APICatalogo.Repository
{
    public class UnitOfWork : IUnitOfWork
    {
        private ProdutoRepository _produtoRepository;
        private CategoriaRepository _categoriaRepository;
        public AppDbContext _Context;
        public UnitOfWork(AppDbContext Context) 
        {
            _Context = Context;
        }

        public IProdutoRepository ProdutoRepository
        {
            get 
            { 
                return _produtoRepository = _produtoRepository ?? new ProdutoRepository(_Context);
            }
        }

        public ICategoriaRepository CategoriaRepository 
        { 
            get 
            { 
                return _categoriaRepository = _categoriaRepository ?? new CategoriaRepository(_Context);
            } 
        }

        public async void commit() 
        {
            await _Context.SaveChangesAsync();
        }

        public void Dispose()
        {
            _Context.Dispose();
        }

        Task IUnitOfWork.commit()
        {
            return _Context.SaveChangesAsync();
        }
    }
}
