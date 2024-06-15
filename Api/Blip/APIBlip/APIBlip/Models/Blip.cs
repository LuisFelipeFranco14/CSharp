namespace Blip
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class BlipJson
    {
        [JsonProperty("flow")]
        public Flow Flow { get; set; }

        [JsonProperty("globalActions")]
        public GlobalActions GlobalActions { get; set; }
    }

    public partial class Flow
    {
        [JsonProperty("onboarding")]
        public Onboarding Onboarding { get; set; }

        [JsonProperty("fallback")]
        public Fallback Fallback { get; set; }

        [JsonProperty("error")]
        public Error Error { get; set; }

        [JsonProperty("be5ebcda-f3e2-48e9-9f0d-d4e421f8fb34")]
        public Be5EbcdaF3E248E99F0DD4E421F8Fb34 Be5EbcdaF3E248E99F0DD4E421F8Fb34 { get; set; }

        [JsonProperty("392fa901-dbf0-4f20-87ae-ab667ce3b11a")]
        public The392Fa901Dbf04F2087AeAb667Ce3B11A The392Fa901Dbf04F2087AeAb667Ce3B11A { get; set; }

        [JsonProperty("b83cf901-b339-46af-8736-f2580c327eba")]
        public GlobalActions B83Cf901B33946Af8736F2580C327Eba { get; set; }

        [JsonProperty("1e9ae353-7350-4eac-baed-5759ac5033c3")]
        public GlobalActions The1E9Ae35373504EacBaed5759Ac5033C3 { get; set; }

        [JsonProperty("34e2d05f-7a7e-48a3-b295-64a8d4810bfa")]
        public GlobalActions The34E2D05F7A7E48A3B29564A8D4810Bfa { get; set; }

        [JsonProperty("4a9105ea-3a4d-475b-ba69-09d51833dc34")]
        public GlobalActions The4A9105Ea3A4D475BBa6909D51833Dc34 { get; set; }

        [JsonProperty("61a64647-8e74-40c5-9310-61875466be20")]
        public GlobalActions The61A646478E7440C5931061875466Be20 { get; set; }

        [JsonProperty("c1deaeae-c24b-4b60-946b-3648e33ec269")]
        public The8_E7F36B0Be0141_A286_BcD9084F57B20A C1DeaeaeC24B4B60946B3648E33Ec269 { get; set; }

        [JsonProperty("8e7f36b0-be01-41a2-86bc-d9084f57b20a")]
        public The8_E7F36B0Be0141_A286_BcD9084F57B20A The8E7F36B0Be0141A286BcD9084F57B20A { get; set; }
    }

    public partial class GlobalActions
    {
        [JsonProperty("$contentActions")]
        public GlobalActionsContentAction[] ContentActions { get; set; }

        [JsonProperty("$conditionOutputs")]
        public ConditionOutput[] ConditionOutputs { get; set; }

        [JsonProperty("$enteringCustomActions")]
        public object[] EnteringCustomActions { get; set; }

        [JsonProperty("$leavingCustomActions")]
        public object[] LeavingCustomActions { get; set; }

        [JsonProperty("$inputSuggestions")]
        public InputSuggestion[] InputSuggestions { get; set; }

        [JsonProperty("$defaultOutput")]
        public GlobalActionsDefaultOutput DefaultOutput { get; set; }

        [JsonProperty("isAiGenerated")]
        public bool IsAiGenerated { get; set; }

        [JsonProperty("$tags")]
        public object[] Tags { get; set; }

        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("root", NullValueHandling = NullValueHandling.Ignore)]
        public bool? Root { get; set; }

        [JsonProperty("$title", NullValueHandling = NullValueHandling.Ignore)]
        public string Title { get; set; }

        [JsonProperty("$position", NullValueHandling = NullValueHandling.Ignore)]
        public Position Position { get; set; }

        [JsonProperty("$invalidContentActions")]
        public bool InvalidContentActions { get; set; }

        [JsonProperty("$invalidOutputs")]
        public bool InvalidOutputs { get; set; }

        [JsonProperty("$invalidCustomActions")]
        public bool InvalidCustomActions { get; set; }

        [JsonProperty("$invalid", NullValueHandling = NullValueHandling.Ignore)]
        public bool? Invalid { get; set; }
    }

    public partial class ConditionOutput
    {
        [JsonProperty("stateId")]
        public string StateId { get; set; }

        [JsonProperty("typeOfStateId", NullValueHandling = NullValueHandling.Ignore)]
        public TypeOfStateId? TypeOfStateId { get; set; }

        [JsonProperty("$connId")]
        public string ConnId { get; set; }

        [JsonProperty("$contentId", NullValueHandling = NullValueHandling.Ignore)]
        public Guid? ContentId { get; set; }

        [JsonProperty("$id")]
        public Guid Id { get; set; }

        [JsonProperty("conditions")]
        public Condition[] Conditions { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public partial class Condition
    {
        [JsonProperty("source")]
        public Source Source { get; set; }

        [JsonProperty("comparison")]
        public Comparison Comparison { get; set; }

        [JsonProperty("values")]
        public string[] Values { get; set; }
    }

    public partial class GlobalActionsContentAction
    {
        [JsonProperty("action", NullValueHandling = NullValueHandling.Ignore)]
        public PurpleAction Action { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }

        [JsonProperty("input", NullValueHandling = NullValueHandling.Ignore)]
        public Input Input { get; set; }
    }

    public partial class PurpleAction
    {
        [JsonProperty("$id")]
        public Guid Id { get; set; }

        [JsonProperty("$typeOfContent")]
        public TypeOfContent TypeOfContent { get; set; }

        [JsonProperty("type")]
        public ActionType Type { get; set; }

        [JsonProperty("settings")]
        public PurpleSettings Settings { get; set; }

        [JsonProperty("$cardContent")]
        public PurpleCardContent CardContent { get; set; }
    }

    public partial class PurpleCardContent
    {
        [JsonProperty("document")]
        public PurpleSettings Document { get; set; }

        [JsonProperty("editable")]
        public bool Editable { get; set; }

        [JsonProperty("deletable")]
        public bool Deletable { get; set; }

        [JsonProperty("position")]
        public PositionEnum Position { get; set; }
    }

    public partial class PurpleSettings
    {
        [JsonProperty("id")]
        public Guid Id { get; set; }

        [JsonProperty("type")]
        public LabelType Type { get; set; }

        [JsonProperty("content")]
        public StickyContent Content { get; set; }

        [JsonProperty("metadata", NullValueHandling = NullValueHandling.Ignore)]
        public Metadata Metadata { get; set; }
    }

    public partial class PurpleContent
    {
        [JsonProperty("text")]
        public Text Text { get; set; }

        [JsonProperty("scope")]
        public Scope Scope { get; set; }

        [JsonProperty("options")]
        public ContentOption[] Options { get; set; }

        [JsonProperty("quikReply")]
        public bool QuikReply { get; set; }
    }

    public partial class ContentOption
    {
        [JsonProperty("text")]
        public InputSuggestion Text { get; set; }

        [JsonProperty("previewText")]
        public InputSuggestion PreviewText { get; set; }

        [JsonProperty("value")]
        public object Value { get; set; }

        [JsonProperty("index")]
        public long Index { get; set; }

        [JsonProperty("type")]
        public object Type { get; set; }
    }

    public partial class Metadata
    {
    }

    public partial class Input
    {
        [JsonProperty("bypass")]
        public bool Bypass { get; set; }

        [JsonProperty("$cardContent")]
        public InputCardContent CardContent { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public partial class InputCardContent
    {
        [JsonProperty("document")]
        public FluffySettings Document { get; set; }

        [JsonProperty("editable")]
        public bool Editable { get; set; }

        [JsonProperty("deletable")]
        public bool Deletable { get; set; }

        [JsonProperty("position")]
        public PositionEnum Position { get; set; }

        [JsonProperty("editing", NullValueHandling = NullValueHandling.Ignore)]
        public bool? Editing { get; set; }
    }

    public partial class FluffySettings
    {
        [JsonProperty("id")]
        public Guid Id { get; set; }

        [JsonProperty("type")]
        public LabelType Type { get; set; }

        [JsonProperty("textContent", NullValueHandling = NullValueHandling.Ignore)]
        public string TextContent { get; set; }

        [JsonProperty("content")]
        public string Content { get; set; }

        [JsonProperty("metadata", NullValueHandling = NullValueHandling.Ignore)]
        public Metadata Metadata { get; set; }
    }

    public partial class GlobalActionsDefaultOutput
    {
        [JsonProperty("stateId")]
        public Id StateId { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public partial class Position
    {
        [JsonProperty("top")]
        public string Top { get; set; }

        [JsonProperty("left")]
        public string Left { get; set; }
    }

    public partial class Be5EbcdaF3E248E99F0DD4E421F8Fb34
    {
        [JsonProperty("$contentActions")]
        public Be5EbcdaF3E248E99F0DD4E421F8Fb34ContentAction[] ContentActions { get; set; }

        [JsonProperty("$conditionOutputs")]
        public ConditionOutput[] ConditionOutputs { get; set; }

        [JsonProperty("$enteringCustomActions")]
        public object[] EnteringCustomActions { get; set; }

        [JsonProperty("$leavingCustomActions")]
        public object[] LeavingCustomActions { get; set; }

        [JsonProperty("$inputSuggestions")]
        public string[] InputSuggestions { get; set; }

        [JsonProperty("$defaultOutput")]
        public The392Fa901Dbf04F2087AeAb667Ce3B11ADefaultOutput DefaultOutput { get; set; }

        [JsonProperty("isAiGenerated")]
        public bool IsAiGenerated { get; set; }

        [JsonProperty("$tags")]
        public object[] Tags { get; set; }

        [JsonProperty("id")]
        public Guid Id { get; set; }

        [JsonProperty("root")]
        public bool Root { get; set; }

        [JsonProperty("$title")]
        public string Title { get; set; }

        [JsonProperty("$position")]
        public Position Position { get; set; }

        [JsonProperty("$invalidContentActions")]
        public bool InvalidContentActions { get; set; }

        [JsonProperty("$invalidOutputs")]
        public bool InvalidOutputs { get; set; }

        [JsonProperty("$invalidCustomActions")]
        public bool InvalidCustomActions { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public partial class Be5EbcdaF3E248E99F0DD4E421F8Fb34ContentAction
    {
        [JsonProperty("action", NullValueHandling = NullValueHandling.Ignore)]
        public TentacledAction Action { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }

        [JsonProperty("input", NullValueHandling = NullValueHandling.Ignore)]
        public Input Input { get; set; }
    }

    public partial class TentacledAction
    {
        [JsonProperty("$id")]
        public Guid Id { get; set; }

        [JsonProperty("$typeOfContent")]
        public string TypeOfContent { get; set; }

        [JsonProperty("type")]
        public ActionType Type { get; set; }

        [JsonProperty("settings")]
        public TentacledSettings Settings { get; set; }

        [JsonProperty("$cardContent")]
        public FluffyCardContent CardContent { get; set; }
    }

    public partial class FluffyCardContent
    {
        [JsonProperty("document")]
        public TentacledSettings Document { get; set; }

        [JsonProperty("editable")]
        public bool Editable { get; set; }

        [JsonProperty("deletable")]
        public bool Deletable { get; set; }

        [JsonProperty("position")]
        public PositionEnum Position { get; set; }
    }

    public partial class TentacledSettings
    {
        [JsonProperty("id")]
        public Guid Id { get; set; }

        [JsonProperty("type")]
        public PurpleType Type { get; set; }

        [JsonProperty("content")]
        public IndigoContent Content { get; set; }

        [JsonProperty("metadata", NullValueHandling = NullValueHandling.Ignore)]
        public Metadata Metadata { get; set; }
    }

    public partial class FluffyContent
    {
        [JsonProperty("itemType")]
        public string ItemType { get; set; }

        [JsonProperty("items")]
        public Item[] Items { get; set; }
    }

    public partial class Item
    {
        [JsonProperty("header")]
        public Header Header { get; set; }

        [JsonProperty("options")]
        public ItemOption[] Options { get; set; }

        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("editing")]
        public bool Editing { get; set; }
    }

    public partial class Header
    {
        [JsonProperty("type")]
        public HeaderType Type { get; set; }

        [JsonProperty("value")]
        public Value Value { get; set; }
    }

    public partial class Value
    {
        [JsonProperty("title")]
        public string Title { get; set; }

        [JsonProperty("text")]
        public string Text { get; set; }

        [JsonProperty("type")]
        public ValueType Type { get; set; }

        [JsonProperty("uri")]
        public string Uri { get; set; }

        [JsonProperty("aspectRatio")]
        public AspectRatio AspectRatio { get; set; }
    }

    public partial class ItemOption
    {
        [JsonProperty("label")]
        public Label Label { get; set; }

        [JsonProperty("value")]
        public object Value { get; set; }
    }

    public partial class Label
    {
        [JsonProperty("type")]
        public LabelType Type { get; set; }

        [JsonProperty("value")]
        public string Value { get; set; }
    }

    public partial class The392Fa901Dbf04F2087AeAb667Ce3B11ADefaultOutput
    {
        [JsonProperty("stateId")]
        public Id StateId { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }

        [JsonProperty("typeOfStateId")]
        public TypeOfStateId TypeOfStateId { get; set; }
    }

    public partial class The8_E7F36B0Be0141_A286_BcD9084F57B20A
    {
        [JsonProperty("$contentActions")]
        public The8E7F36B0Be0141A286BcD9084F57B20AContentAction[] ContentActions { get; set; }

        [JsonProperty("$conditionOutputs")]
        public object[] ConditionOutputs { get; set; }

        [JsonProperty("$enteringCustomActions")]
        public object[] EnteringCustomActions { get; set; }

        [JsonProperty("$leavingCustomActions")]
        public object[] LeavingCustomActions { get; set; }

        [JsonProperty("$inputSuggestions")]
        public object[] InputSuggestions { get; set; }

        [JsonProperty("$defaultOutput")]
        public GlobalActionsDefaultOutput DefaultOutput { get; set; }

        [JsonProperty("isAiGenerated")]
        public bool IsAiGenerated { get; set; }

        [JsonProperty("$tags")]
        public object[] Tags { get; set; }

        [JsonProperty("id")]
        public Guid Id { get; set; }

        [JsonProperty("root")]
        public bool Root { get; set; }

        [JsonProperty("$title")]
        public string Title { get; set; }

        [JsonProperty("$position")]
        public Position Position { get; set; }

        [JsonProperty("$invalidContentActions")]
        public bool InvalidContentActions { get; set; }

        [JsonProperty("$invalidOutputs")]
        public bool InvalidOutputs { get; set; }

        [JsonProperty("$invalidCustomActions")]
        public bool InvalidCustomActions { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public partial class The8E7F36B0Be0141A286BcD9084F57B20AContentAction
    {
        [JsonProperty("action", NullValueHandling = NullValueHandling.Ignore)]
        public FluffyAction Action { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }

        [JsonProperty("input", NullValueHandling = NullValueHandling.Ignore)]
        public Input Input { get; set; }
    }

    public partial class FluffyAction
    {
        [JsonProperty("$id")]
        public Guid Id { get; set; }

        [JsonProperty("$typeOfContent")]
        public TypeOfContent TypeOfContent { get; set; }

        [JsonProperty("type")]
        public ActionType Type { get; set; }

        [JsonProperty("settings")]
        public FluffySettings Settings { get; set; }

        [JsonProperty("$cardContent")]
        public InputCardContent CardContent { get; set; }
    }

    public partial class Error
    {
        [JsonProperty("$contentActions")]
        public ErrorContentAction[] ContentActions { get; set; }

        [JsonProperty("$conditionOutputs")]
        public object[] ConditionOutputs { get; set; }

        [JsonProperty("$enteringCustomActions")]
        public object[] EnteringCustomActions { get; set; }

        [JsonProperty("$leavingCustomActions")]
        public object[] LeavingCustomActions { get; set; }

        [JsonProperty("$inputSuggestions")]
        public object[] InputSuggestions { get; set; }

        [JsonProperty("$defaultOutput")]
        public GlobalActionsDefaultOutput DefaultOutput { get; set; }

        [JsonProperty("isAiGenerated")]
        public bool IsAiGenerated { get; set; }

        [JsonProperty("$tags")]
        public object[] Tags { get; set; }

        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("$title")]
        public string Title { get; set; }

        [JsonProperty("$position")]
        public Position Position { get; set; }

        [JsonProperty("$invalidContentActions")]
        public bool InvalidContentActions { get; set; }

        [JsonProperty("$invalidOutputs")]
        public bool InvalidOutputs { get; set; }

        [JsonProperty("$invalidCustomActions")]
        public bool InvalidCustomActions { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public partial class ErrorContentAction
    {
        [JsonProperty("action", NullValueHandling = NullValueHandling.Ignore)]
        public StickyAction Action { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }

        [JsonProperty("input", NullValueHandling = NullValueHandling.Ignore)]
        public Input Input { get; set; }
    }

    public partial class StickyAction
    {
        [JsonProperty("$id")]
        public Guid Id { get; set; }

        [JsonProperty("$typeOfContent")]
        public string TypeOfContent { get; set; }

        [JsonProperty("type")]
        public ActionType Type { get; set; }

        [JsonProperty("settings")]
        public StickySettings Settings { get; set; }

        [JsonProperty("$cardContent")]
        public TentacledCardContent CardContent { get; set; }
    }

    public partial class TentacledCardContent
    {
        [JsonProperty("document")]
        public StickySettings Document { get; set; }

        [JsonProperty("editable")]
        public bool Editable { get; set; }

        [JsonProperty("deletable")]
        public bool Deletable { get; set; }

        [JsonProperty("position")]
        public PositionEnum Position { get; set; }

        [JsonProperty("editing")]
        public bool Editing { get; set; }
    }

    public partial class StickySettings
    {
        [JsonProperty("id")]
        public Guid Id { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("content")]
        public IndecentContent Content { get; set; }

        [JsonProperty("metadata", NullValueHandling = NullValueHandling.Ignore)]
        public Metadata Metadata { get; set; }
    }

    public partial class TentacledContent
    {
        [JsonProperty("state")]
        public string State { get; set; }

        [JsonProperty("interval")]
        public long Interval { get; set; }
    }

    public partial class Fallback
    {
        [JsonProperty("$contentActions")]
        public FallbackContentAction[] ContentActions { get; set; }

        [JsonProperty("$conditionOutputs")]
        public ConditionOutput[] ConditionOutputs { get; set; }

        [JsonProperty("$enteringCustomActions")]
        public object[] EnteringCustomActions { get; set; }

        [JsonProperty("$leavingCustomActions")]
        public object[] LeavingCustomActions { get; set; }

        [JsonProperty("$inputSuggestions")]
        public object[] InputSuggestions { get; set; }

        [JsonProperty("$defaultOutput")]
        public GlobalActionsDefaultOutput DefaultOutput { get; set; }

        [JsonProperty("isAiGenerated")]
        public bool IsAiGenerated { get; set; }

        [JsonProperty("$tags")]
        public object[] Tags { get; set; }

        [JsonProperty("id")]
        public Id Id { get; set; }

        [JsonProperty("$title")]
        public string Title { get; set; }

        [JsonProperty("$position")]
        public Position Position { get; set; }

        [JsonProperty("$invalidContentActions")]
        public bool InvalidContentActions { get; set; }

        [JsonProperty("$invalidOutputs")]
        public bool InvalidOutputs { get; set; }

        [JsonProperty("$invalidCustomActions")]
        public bool InvalidCustomActions { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public partial class FallbackContentAction
    {
        [JsonProperty("input")]
        public Input Input { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public partial class Onboarding
    {
        [JsonProperty("$contentActions")]
        public FallbackContentAction[] ContentActions { get; set; }

        [JsonProperty("$conditionOutputs")]
        public ConditionOutput[] ConditionOutputs { get; set; }

        [JsonProperty("$enteringCustomActions")]
        public object[] EnteringCustomActions { get; set; }

        [JsonProperty("$leavingCustomActions")]
        public object[] LeavingCustomActions { get; set; }

        [JsonProperty("$inputSuggestions")]
        public object[] InputSuggestions { get; set; }

        [JsonProperty("$defaultOutput")]
        public GlobalActionsDefaultOutput DefaultOutput { get; set; }

        [JsonProperty("isAiGenerated")]
        public bool IsAiGenerated { get; set; }

        [JsonProperty("$tags")]
        public object[] Tags { get; set; }

        [JsonProperty("id")]
        public Id Id { get; set; }

        [JsonProperty("root")]
        public bool Root { get; set; }

        [JsonProperty("$title")]
        public string Title { get; set; }

        [JsonProperty("$position")]
        public Position Position { get; set; }

        [JsonProperty("$invalidContentActions")]
        public bool InvalidContentActions { get; set; }

        [JsonProperty("$invalidOutputs")]
        public bool InvalidOutputs { get; set; }

        [JsonProperty("$invalidCustomActions")]
        public bool InvalidCustomActions { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public partial class The392Fa901Dbf04F2087AeAb667Ce3B11A
    {
        [JsonProperty("$contentActions")]
        public GlobalActionsContentAction[] ContentActions { get; set; }

        [JsonProperty("$conditionOutputs")]
        public ConditionOutput[] ConditionOutputs { get; set; }

        [JsonProperty("$enteringCustomActions")]
        public object[] EnteringCustomActions { get; set; }

        [JsonProperty("$leavingCustomActions")]
        public object[] LeavingCustomActions { get; set; }

        [JsonProperty("$inputSuggestions")]
        public InputSuggestion[] InputSuggestions { get; set; }

        [JsonProperty("$defaultOutput")]
        public The392Fa901Dbf04F2087AeAb667Ce3B11ADefaultOutput DefaultOutput { get; set; }

        [JsonProperty("isAiGenerated")]
        public bool IsAiGenerated { get; set; }

        [JsonProperty("$tags")]
        public object[] Tags { get; set; }

        [JsonProperty("id")]
        public Guid Id { get; set; }

        [JsonProperty("root")]
        public bool Root { get; set; }

        [JsonProperty("$title")]
        public string Title { get; set; }

        [JsonProperty("$position")]
        public Position Position { get; set; }

        [JsonProperty("$invalidContentActions")]
        public bool InvalidContentActions { get; set; }

        [JsonProperty("$invalidOutputs")]
        public bool InvalidOutputs { get; set; }

        [JsonProperty("$invalidCustomActions")]
        public bool InvalidCustomActions { get; set; }

        [JsonProperty("$invalid")]
        public bool Invalid { get; set; }
    }

    public enum Comparison { Equals, Exists, Matches };

    public enum Source { Input };

    public enum TypeOfStateId { State };

    public enum InputSuggestion { Be, Charge, Desafio, Excellence, Higher, InputSuggestionTeam, Simple, Team };

    public enum Scope { Immediate };

    public enum Text { SeQuiserSaberMaisSobreOutrosValoresÉSóFalar };

    public enum LabelType { ApplicationVndLimeSelectJson, TextPlain };

    public enum PositionEnum { Left, Right };

    public enum ActionType { SendMessage };

    public enum TypeOfContent { SelectImmediate, Text };

    public enum Id { Fallback, Onboarding };

    public enum HeaderType { ApplicationVndLimeMediaLinkJson };

    public enum AspectRatio { The11 };

    public enum ValueType { ImageJpeg };

    public enum PurpleType { ApplicationVndLimeCollectionJson, TextPlain };

    public partial struct StickyContent
    {
        public PurpleContent PurpleContent;
        public string String;

        public static implicit operator StickyContent(PurpleContent PurpleContent) => new StickyContent { PurpleContent = PurpleContent };
        public static implicit operator StickyContent(string String) => new StickyContent { String = String };
    }

    public partial struct IndigoContent
    {
        public FluffyContent FluffyContent;
        public string String;

        public static implicit operator IndigoContent(FluffyContent FluffyContent) => new IndigoContent { FluffyContent = FluffyContent };
        public static implicit operator IndigoContent(string String) => new IndigoContent { String = String };
    }

    public partial struct IndecentContent
    {
        public string String;
        public TentacledContent TentacledContent;

        public static implicit operator IndecentContent(string String) => new IndecentContent { String = String };
        public static implicit operator IndecentContent(TentacledContent TentacledContent) => new IndecentContent { TentacledContent = TentacledContent };
    }

    public partial class Welcome1
    {
        public static Welcome1 FromJson(string json) => JsonConvert.DeserializeObject<Welcome1>(json, Blip.Converter.Settings);
    }

    public static class Serialize
    {
        public static string ToJson(this Welcome1 self) => JsonConvert.SerializeObject(self, Blip.Converter.Settings);
    }

    internal static class Converter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters =
            {
                ComparisonConverter.Singleton,
                SourceConverter.Singleton,
                TypeOfStateIdConverter.Singleton,
                StickyContentConverter.Singleton,
                InputSuggestionConverter.Singleton,
                ScopeConverter.Singleton,
                TextConverter.Singleton,
                LabelTypeConverter.Singleton,
                PositionEnumConverter.Singleton,
                TypeOfContentConverter.Singleton,
                ActionTypeConverter.Singleton,
                IdConverter.Singleton,
                IndigoContentConverter.Singleton,
                HeaderTypeConverter.Singleton,
                AspectRatioConverter.Singleton,
                ValueTypeConverter.Singleton,
                PurpleTypeConverter.Singleton,
                IndecentContentConverter.Singleton,
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
        };
    }

    internal class ComparisonConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Comparison) || t == typeof(Comparison?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "equals":
                    return Comparison.Equals;
                case "exists":
                    return Comparison.Exists;
                case "matches":
                    return Comparison.Matches;
            }
            throw new Exception("Cannot unmarshal type Comparison");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Comparison)untypedValue;
            switch (value)
            {
                case Comparison.Equals:
                    serializer.Serialize(writer, "equals");
                    return;
                case Comparison.Exists:
                    serializer.Serialize(writer, "exists");
                    return;
                case Comparison.Matches:
                    serializer.Serialize(writer, "matches");
                    return;
            }
            throw new Exception("Cannot marshal type Comparison");
        }

        public static readonly ComparisonConverter Singleton = new ComparisonConverter();
    }

    internal class SourceConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Source) || t == typeof(Source?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "input")
            {
                return Source.Input;
            }
            throw new Exception("Cannot unmarshal type Source");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Source)untypedValue;
            if (value == Source.Input)
            {
                serializer.Serialize(writer, "input");
                return;
            }
            throw new Exception("Cannot marshal type Source");
        }

        public static readonly SourceConverter Singleton = new SourceConverter();
    }

    internal class TypeOfStateIdConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(TypeOfStateId) || t == typeof(TypeOfStateId?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "state")
            {
                return TypeOfStateId.State;
            }
            throw new Exception("Cannot unmarshal type TypeOfStateId");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (TypeOfStateId)untypedValue;
            if (value == TypeOfStateId.State)
            {
                serializer.Serialize(writer, "state");
                return;
            }
            throw new Exception("Cannot marshal type TypeOfStateId");
        }

        public static readonly TypeOfStateIdConverter Singleton = new TypeOfStateIdConverter();
    }

    internal class StickyContentConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(StickyContent) || t == typeof(StickyContent?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            switch (reader.TokenType)
            {
                case JsonToken.String:
                case JsonToken.Date:
                    var stringValue = serializer.Deserialize<string>(reader);
                    return new StickyContent { String = stringValue };
                case JsonToken.StartObject:
                    var objectValue = serializer.Deserialize<PurpleContent>(reader);
                    return new StickyContent { PurpleContent = objectValue };
            }
            throw new Exception("Cannot unmarshal type StickyContent");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            var value = (StickyContent)untypedValue;
            if (value.String != null)
            {
                serializer.Serialize(writer, value.String);
                return;
            }
            if (value.PurpleContent != null)
            {
                serializer.Serialize(writer, value.PurpleContent);
                return;
            }
            throw new Exception("Cannot marshal type StickyContent");
        }

        public static readonly StickyContentConverter Singleton = new StickyContentConverter();
    }

    internal class InputSuggestionConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(InputSuggestion) || t == typeof(InputSuggestion?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "⚡Charge":
                    return InputSuggestion.Charge;
                case "⭐Excellence":
                    return InputSuggestion.Excellence;
                case "\ud83c\udfafSimple":
                    return InputSuggestion.Simple;
                case "\ud83c\udff3 Team":
                    return InputSuggestion.InputSuggestionTeam;
                case "\ud83c\udff3Team":
                    return InputSuggestion.Team;
                case "\ud83d\udc99Be":
                    return InputSuggestion.Be;
                case "\ud83d\udca1Desafio":
                    return InputSuggestion.Desafio;
                case "\ud83d\ude80Higher":
                    return InputSuggestion.Higher;
            }
            throw new Exception("Cannot unmarshal type InputSuggestion");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (InputSuggestion)untypedValue;
            switch (value)
            {
                case InputSuggestion.Charge:
                    serializer.Serialize(writer, "⚡Charge");
                    return;
                case InputSuggestion.Excellence:
                    serializer.Serialize(writer, "⭐Excellence");
                    return;
                case InputSuggestion.Simple:
                    serializer.Serialize(writer, "\ud83c\udfafSimple");
                    return;
                case InputSuggestion.InputSuggestionTeam:
                    serializer.Serialize(writer, "\ud83c\udff3 Team");
                    return;
                case InputSuggestion.Team:
                    serializer.Serialize(writer, "\ud83c\udff3Team");
                    return;
                case InputSuggestion.Be:
                    serializer.Serialize(writer, "\ud83d\udc99Be");
                    return;
                case InputSuggestion.Desafio:
                    serializer.Serialize(writer, "\ud83d\udca1Desafio");
                    return;
                case InputSuggestion.Higher:
                    serializer.Serialize(writer, "\ud83d\ude80Higher");
                    return;
            }
            throw new Exception("Cannot marshal type InputSuggestion");
        }

        public static readonly InputSuggestionConverter Singleton = new InputSuggestionConverter();
    }

    internal class ScopeConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Scope) || t == typeof(Scope?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "immediate")
            {
                return Scope.Immediate;
            }
            throw new Exception("Cannot unmarshal type Scope");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Scope)untypedValue;
            if (value == Scope.Immediate)
            {
                serializer.Serialize(writer, "immediate");
                return;
            }
            throw new Exception("Cannot marshal type Scope");
        }

        public static readonly ScopeConverter Singleton = new ScopeConverter();
    }

    internal class TextConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Text) || t == typeof(Text?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "Se quiser saber mais sobre outros valores é só falar")
            {
                return Text.SeQuiserSaberMaisSobreOutrosValoresÉSóFalar;
            }
            throw new Exception("Cannot unmarshal type Text");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Text)untypedValue;
            if (value == Text.SeQuiserSaberMaisSobreOutrosValoresÉSóFalar)
            {
                serializer.Serialize(writer, "Se quiser saber mais sobre outros valores é só falar");
                return;
            }
            throw new Exception("Cannot marshal type Text");
        }

        public static readonly TextConverter Singleton = new TextConverter();
    }

    internal class LabelTypeConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(LabelType) || t == typeof(LabelType?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "application/vnd.lime.select+json":
                    return LabelType.ApplicationVndLimeSelectJson;
                case "text/plain":
                    return LabelType.TextPlain;
            }
            throw new Exception("Cannot unmarshal type LabelType");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (LabelType)untypedValue;
            switch (value)
            {
                case LabelType.ApplicationVndLimeSelectJson:
                    serializer.Serialize(writer, "application/vnd.lime.select+json");
                    return;
                case LabelType.TextPlain:
                    serializer.Serialize(writer, "text/plain");
                    return;
            }
            throw new Exception("Cannot marshal type LabelType");
        }

        public static readonly LabelTypeConverter Singleton = new LabelTypeConverter();
    }

    internal class PositionEnumConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(PositionEnum) || t == typeof(PositionEnum?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "left":
                    return PositionEnum.Left;
                case "right":
                    return PositionEnum.Right;
            }
            throw new Exception("Cannot unmarshal type PositionEnum");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (PositionEnum)untypedValue;
            switch (value)
            {
                case PositionEnum.Left:
                    serializer.Serialize(writer, "left");
                    return;
                case PositionEnum.Right:
                    serializer.Serialize(writer, "right");
                    return;
            }
            throw new Exception("Cannot marshal type PositionEnum");
        }

        public static readonly PositionEnumConverter Singleton = new PositionEnumConverter();
    }

    internal class TypeOfContentConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(TypeOfContent) || t == typeof(TypeOfContent?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "select-immediate":
                    return TypeOfContent.SelectImmediate;
                case "text":
                    return TypeOfContent.Text;
            }
            throw new Exception("Cannot unmarshal type TypeOfContent");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (TypeOfContent)untypedValue;
            switch (value)
            {
                case TypeOfContent.SelectImmediate:
                    serializer.Serialize(writer, "select-immediate");
                    return;
                case TypeOfContent.Text:
                    serializer.Serialize(writer, "text");
                    return;
            }
            throw new Exception("Cannot marshal type TypeOfContent");
        }

        public static readonly TypeOfContentConverter Singleton = new TypeOfContentConverter();
    }

    internal class ActionTypeConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(ActionType) || t == typeof(ActionType?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "SendMessage")
            {
                return ActionType.SendMessage;
            }
            throw new Exception("Cannot unmarshal type ActionType");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (ActionType)untypedValue;
            if (value == ActionType.SendMessage)
            {
                serializer.Serialize(writer, "SendMessage");
                return;
            }
            throw new Exception("Cannot marshal type ActionType");
        }

        public static readonly ActionTypeConverter Singleton = new ActionTypeConverter();
    }

    internal class IdConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Id) || t == typeof(Id?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "fallback":
                    return Id.Fallback;
                case "onboarding":
                    return Id.Onboarding;
            }
            throw new Exception("Cannot unmarshal type Id");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Id)untypedValue;
            switch (value)
            {
                case Id.Fallback:
                    serializer.Serialize(writer, "fallback");
                    return;
                case Id.Onboarding:
                    serializer.Serialize(writer, "onboarding");
                    return;
            }
            throw new Exception("Cannot marshal type Id");
        }

        public static readonly IdConverter Singleton = new IdConverter();
    }

    internal class IndigoContentConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(IndigoContent) || t == typeof(IndigoContent?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            switch (reader.TokenType)
            {
                case JsonToken.String:
                case JsonToken.Date:
                    var stringValue = serializer.Deserialize<string>(reader);
                    return new IndigoContent { String = stringValue };
                case JsonToken.StartObject:
                    var objectValue = serializer.Deserialize<FluffyContent>(reader);
                    return new IndigoContent { FluffyContent = objectValue };
            }
            throw new Exception("Cannot unmarshal type IndigoContent");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            var value = (IndigoContent)untypedValue;
            if (value.String != null)
            {
                serializer.Serialize(writer, value.String);
                return;
            }
            if (value.FluffyContent != null)
            {
                serializer.Serialize(writer, value.FluffyContent);
                return;
            }
            throw new Exception("Cannot marshal type IndigoContent");
        }

        public static readonly IndigoContentConverter Singleton = new IndigoContentConverter();
    }

    internal class HeaderTypeConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(HeaderType) || t == typeof(HeaderType?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "application/vnd.lime.media-link+json")
            {
                return HeaderType.ApplicationVndLimeMediaLinkJson;
            }
            throw new Exception("Cannot unmarshal type HeaderType");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (HeaderType)untypedValue;
            if (value == HeaderType.ApplicationVndLimeMediaLinkJson)
            {
                serializer.Serialize(writer, "application/vnd.lime.media-link+json");
                return;
            }
            throw new Exception("Cannot marshal type HeaderType");
        }

        public static readonly HeaderTypeConverter Singleton = new HeaderTypeConverter();
    }

    internal class AspectRatioConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(AspectRatio) || t == typeof(AspectRatio?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "1:1")
            {
                return AspectRatio.The11;
            }
            throw new Exception("Cannot unmarshal type AspectRatio");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (AspectRatio)untypedValue;
            if (value == AspectRatio.The11)
            {
                serializer.Serialize(writer, "1:1");
                return;
            }
            throw new Exception("Cannot marshal type AspectRatio");
        }

        public static readonly AspectRatioConverter Singleton = new AspectRatioConverter();
    }

    internal class ValueTypeConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(ValueType) || t == typeof(ValueType?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "image/jpeg")
            {
                return ValueType.ImageJpeg;
            }
            throw new Exception("Cannot unmarshal type ValueType");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (ValueType)untypedValue;
            if (value == ValueType.ImageJpeg)
            {
                serializer.Serialize(writer, "image/jpeg");
                return;
            }
            throw new Exception("Cannot marshal type ValueType");
        }

        public static readonly ValueTypeConverter Singleton = new ValueTypeConverter();
    }

    internal class PurpleTypeConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(PurpleType) || t == typeof(PurpleType?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "application/vnd.lime.collection+json":
                    return PurpleType.ApplicationVndLimeCollectionJson;
                case "text/plain":
                    return PurpleType.TextPlain;
            }
            throw new Exception("Cannot unmarshal type PurpleType");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (PurpleType)untypedValue;
            switch (value)
            {
                case PurpleType.ApplicationVndLimeCollectionJson:
                    serializer.Serialize(writer, "application/vnd.lime.collection+json");
                    return;
                case PurpleType.TextPlain:
                    serializer.Serialize(writer, "text/plain");
                    return;
            }
            throw new Exception("Cannot marshal type PurpleType");
        }

        public static readonly PurpleTypeConverter Singleton = new PurpleTypeConverter();
    }

    internal class IndecentContentConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(IndecentContent) || t == typeof(IndecentContent?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            switch (reader.TokenType)
            {
                case JsonToken.String:
                case JsonToken.Date:
                    var stringValue = serializer.Deserialize<string>(reader);
                    return new IndecentContent { String = stringValue };
                case JsonToken.StartObject:
                    var objectValue = serializer.Deserialize<TentacledContent>(reader);
                    return new IndecentContent { TentacledContent = objectValue };
            }
            throw new Exception("Cannot unmarshal type IndecentContent");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            var value = (IndecentContent)untypedValue;
            if (value.String != null)
            {
                serializer.Serialize(writer, value.String);
                return;
            }
            if (value.TentacledContent != null)
            {
                serializer.Serialize(writer, value.TentacledContent);
                return;
            }
            throw new Exception("Cannot marshal type IndecentContent");
        }

        public static readonly IndecentContentConverter Singleton = new IndecentContentConverter();
    }
}
