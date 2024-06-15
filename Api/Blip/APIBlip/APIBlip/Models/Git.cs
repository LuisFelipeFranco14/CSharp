namespace Git
{
    using System;
    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class Repos
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("node_id")]
        public string NodeId { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("full_name")]
        public string FullName { get; set; }

        [JsonProperty("private")]
        public bool Private { get; set; }

        [JsonProperty("owner")]
        public Owner Owner { get; set; }

        [JsonProperty("html_url")]
        public string HtmlUrl { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }

        [JsonProperty("fork")]
        public bool Fork { get; set; }

        [JsonProperty("url")]
        public Uri Url { get; set; }

        [JsonProperty("forks_url")]
        public Uri ForksUrl { get; set; }

        [JsonProperty("keys_url")]
        public string KeysUrl { get; set; }

        [JsonProperty("collaborators_url")]
        public string CollaboratorsUrl { get; set; }

        [JsonProperty("teams_url")]
        public Uri TeamsUrl { get; set; }

        [JsonProperty("hooks_url")]
        public Uri HooksUrl { get; set; }

        [JsonProperty("issue_events_url")]
        public string IssueEventsUrl { get; set; }

        [JsonProperty("events_url")]
        public Uri EventsUrl { get; set; }

        [JsonProperty("assignees_url")]
        public string AssigneesUrl { get; set; }

        [JsonProperty("branches_url")]
        public string BranchesUrl { get; set; }

        [JsonProperty("tags_url")]
        public Uri TagsUrl { get; set; }

        [JsonProperty("blobs_url")]
        public string BlobsUrl { get; set; }

        [JsonProperty("git_tags_url")]
        public string GitTagsUrl { get; set; }

        [JsonProperty("git_refs_url")]
        public string GitRefsUrl { get; set; }

        [JsonProperty("trees_url")]
        public string TreesUrl { get; set; }

        [JsonProperty("statuses_url")]
        public string StatusesUrl { get; set; }

        [JsonProperty("languages_url")]
        public Uri LanguagesUrl { get; set; }

        [JsonProperty("stargazers_url")]
        public Uri StargazersUrl { get; set; }

        [JsonProperty("contributors_url")]
        public Uri ContributorsUrl { get; set; }

        [JsonProperty("subscribers_url")]
        public Uri SubscribersUrl { get; set; }

        [JsonProperty("subscription_url")]
        public Uri SubscriptionUrl { get; set; }

        [JsonProperty("commits_url")]
        public string CommitsUrl { get; set; }

        [JsonProperty("git_commits_url")]
        public string GitCommitsUrl { get; set; }

        [JsonProperty("comments_url")]
        public string CommentsUrl { get; set; }

        [JsonProperty("issue_comment_url")]
        public string IssueCommentUrl { get; set; }

        [JsonProperty("contents_url")]
        public string ContentsUrl { get; set; }

        [JsonProperty("compare_url")]
        public string CompareUrl { get; set; }

        [JsonProperty("merges_url")]
        public Uri MergesUrl { get; set; }

        [JsonProperty("archive_url")]
        public string ArchiveUrl { get; set; }

        [JsonProperty("downloads_url")]
        public Uri DownloadsUrl { get; set; }

        [JsonProperty("issues_url")]
        public string IssuesUrl { get; set; }

        [JsonProperty("pulls_url")]
        public string PullsUrl { get; set; }

        [JsonProperty("milestones_url")]
        public string MilestonesUrl { get; set; }

        [JsonProperty("notifications_url")]
        public string NotificationsUrl { get; set; }

        [JsonProperty("labels_url")]
        public string LabelsUrl { get; set; }

        [JsonProperty("releases_url")]
        public string ReleasesUrl { get; set; }

        [JsonProperty("deployments_url")]
        public Uri DeploymentsUrl { get; set; }

        [JsonProperty("created_at")]
        public DateTimeOffset CreatedAt { get; set; }

        [JsonProperty("updated_at")]
        public DateTimeOffset UpdatedAt { get; set; }

        [JsonProperty("pushed_at")]
        public DateTimeOffset PushedAt { get; set; }

        [JsonProperty("git_url")]
        public string GitUrl { get; set; }

        [JsonProperty("ssh_url")]
        public string SshUrl { get; set; }

        [JsonProperty("clone_url")]
        public Uri CloneUrl { get; set; }

        [JsonProperty("svn_url")]
        public Uri SvnUrl { get; set; }

        [JsonProperty("homepage")]
        public string Homepage { get; set; }

        [JsonProperty("size")]
        public long Size { get; set; }

        [JsonProperty("stargazers_count")]
        public long StargazersCount { get; set; }

        [JsonProperty("watchers_count")]
        public long WatchersCount { get; set; }

        [JsonProperty("language")]
        public string Language { get; set; }

        [JsonProperty("has_issues")]
        public bool HasIssues { get; set; }

        [JsonProperty("has_projects")]
        public bool HasProjects { get; set; }

        [JsonProperty("has_downloads")]
        public bool HasDownloads { get; set; }

        [JsonProperty("has_wiki")]
        public bool HasWiki { get; set; }

        [JsonProperty("has_pages")]
        public bool HasPages { get; set; }

        [JsonProperty("has_discussions")]
        public bool HasDiscussions { get; set; }

        [JsonProperty("forks_count")]
        public long ForksCount { get; set; }

        [JsonProperty("mirror_url")]
        public object MirrorUrl { get; set; }

        [JsonProperty("archived")]
        public bool Archived { get; set; }

        [JsonProperty("disabled")]
        public bool Disabled { get; set; }

        [JsonProperty("open_issues_count")]
        public long OpenIssuesCount { get; set; }

        [JsonProperty("license")]
        public License License { get; set; }

        [JsonProperty("allow_forking")]
        public bool AllowForking { get; set; }

        [JsonProperty("is_template")]
        public bool IsTemplate { get; set; }

        [JsonProperty("web_commit_signoff_required")]
        public bool WebCommitSignoffRequired { get; set; }

        [JsonProperty("topics")]
        public string[] Topics { get; set; }

        [JsonProperty("visibility")]
        public Visibility Visibility { get; set; }

        [JsonProperty("forks")]
        public long Forks { get; set; }

        [JsonProperty("open_issues")]
        public long OpenIssues { get; set; }

        [JsonProperty("watchers")]
        public long Watchers { get; set; }

        [JsonProperty("default_branch")]
        public DefaultBranch DefaultBranch { get; set; }
    }

    public partial class License
    {
        [JsonProperty("key")]
        public string Key { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("spdx_id")]
        public string SpdxId { get; set; }

        [JsonProperty("url")]
        public Uri Url { get; set; }

        [JsonProperty("node_id")]
        public string NodeId { get; set; }
    }

    public partial class Owner
    {
        [JsonProperty("login")]
        public Login Login { get; set; }

        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("node_id")]
        public NodeId NodeId { get; set; }

        [JsonProperty("avatar_url")]
        public Uri AvatarUrl { get; set; }

        [JsonProperty("gravatar_id")]
        public string GravatarId { get; set; }

        [JsonProperty("url")]
        public Uri Url { get; set; }

        [JsonProperty("html_url")]
        public Uri HtmlUrl { get; set; }

        [JsonProperty("followers_url")]
        public Uri FollowersUrl { get; set; }

        [JsonProperty("following_url")]
        public FollowingUrl FollowingUrl { get; set; }

        [JsonProperty("gists_url")]
        public GistsUrl GistsUrl { get; set; }

        [JsonProperty("starred_url")]
        public StarredUrl StarredUrl { get; set; }

        [JsonProperty("subscriptions_url")]
        public Uri SubscriptionsUrl { get; set; }

        [JsonProperty("organizations_url")]
        public Uri OrganizationsUrl { get; set; }

        [JsonProperty("repos_url")]
        public Uri ReposUrl { get; set; }

        [JsonProperty("events_url")]
        public EventsUrl EventsUrl { get; set; }

        [JsonProperty("received_events_url")]
        public Uri ReceivedEventsUrl { get; set; }

        [JsonProperty("type")]
        public TypeEnum Type { get; set; }

        [JsonProperty("site_admin")]
        public bool SiteAdmin { get; set; }
    }

    public enum DefaultBranch { Main, Master };

    public enum EventsUrl { HttpsApiGithubComUsersTakenetEventsPrivacy };

    public enum FollowingUrl { HttpsApiGithubComUsersTakenetFollowingOtherUser };

    public enum GistsUrl { HttpsApiGithubComUsersTakenetGistsGistId };

    public enum Login { Takenet };

    public enum NodeId { MdEyOk9YZ2FuaXphdGlvbjQzNjk1MjI };

    public enum StarredUrl { HttpsApiGithubComUsersTakenetStarredOwnerRepo };

    public enum TypeEnum { Organization };

    public enum Visibility { Public };

    public partial class Welcome2
    {
        public static Welcome2[] FromJson(string json) => JsonConvert.DeserializeObject<Welcome2[]>(json, Git.Converter.Settings);
    }

    public static class Serialize
    {
        public static string ToJson(this Welcome2[] self) => JsonConvert.SerializeObject(self, Git.Converter.Settings);
    }

    internal static class Converter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters =
            {
                DefaultBranchConverter.Singleton,
                EventsUrlConverter.Singleton,
                FollowingUrlConverter.Singleton,
                GistsUrlConverter.Singleton,
                LoginConverter.Singleton,
                NodeIdConverter.Singleton,
                StarredUrlConverter.Singleton,
                TypeEnumConverter.Singleton,
                VisibilityConverter.Singleton,
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
        };
    }

    internal class DefaultBranchConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(DefaultBranch) || t == typeof(DefaultBranch?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "main":
                    return DefaultBranch.Main;
                case "master":
                    return DefaultBranch.Master;
            }
            throw new Exception("Cannot unmarshal type DefaultBranch");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (DefaultBranch)untypedValue;
            switch (value)
            {
                case DefaultBranch.Main:
                    serializer.Serialize(writer, "main");
                    return;
                case DefaultBranch.Master:
                    serializer.Serialize(writer, "master");
                    return;
            }
            throw new Exception("Cannot marshal type DefaultBranch");
        }

        public static readonly DefaultBranchConverter Singleton = new DefaultBranchConverter();
    }

    internal class EventsUrlConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(EventsUrl) || t == typeof(EventsUrl?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "https://api.github.com/users/takenet/events{/privacy}")
            {
                return EventsUrl.HttpsApiGithubComUsersTakenetEventsPrivacy;
            }
            throw new Exception("Cannot unmarshal type EventsUrl");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (EventsUrl)untypedValue;
            if (value == EventsUrl.HttpsApiGithubComUsersTakenetEventsPrivacy)
            {
                serializer.Serialize(writer, "https://api.github.com/users/takenet/events{/privacy}");
                return;
            }
            throw new Exception("Cannot marshal type EventsUrl");
        }

        public static readonly EventsUrlConverter Singleton = new EventsUrlConverter();
    }

    internal class FollowingUrlConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(FollowingUrl) || t == typeof(FollowingUrl?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "https://api.github.com/users/takenet/following{/other_user}")
            {
                return FollowingUrl.HttpsApiGithubComUsersTakenetFollowingOtherUser;
            }
            throw new Exception("Cannot unmarshal type FollowingUrl");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (FollowingUrl)untypedValue;
            if (value == FollowingUrl.HttpsApiGithubComUsersTakenetFollowingOtherUser)
            {
                serializer.Serialize(writer, "https://api.github.com/users/takenet/following{/other_user}");
                return;
            }
            throw new Exception("Cannot marshal type FollowingUrl");
        }

        public static readonly FollowingUrlConverter Singleton = new FollowingUrlConverter();
    }

    internal class GistsUrlConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(GistsUrl) || t == typeof(GistsUrl?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "https://api.github.com/users/takenet/gists{/gist_id}")
            {
                return GistsUrl.HttpsApiGithubComUsersTakenetGistsGistId;
            }
            throw new Exception("Cannot unmarshal type GistsUrl");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (GistsUrl)untypedValue;
            if (value == GistsUrl.HttpsApiGithubComUsersTakenetGistsGistId)
            {
                serializer.Serialize(writer, "https://api.github.com/users/takenet/gists{/gist_id}");
                return;
            }
            throw new Exception("Cannot marshal type GistsUrl");
        }

        public static readonly GistsUrlConverter Singleton = new GistsUrlConverter();
    }

    internal class LoginConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Login) || t == typeof(Login?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "takenet")
            {
                return Login.Takenet;
            }
            throw new Exception("Cannot unmarshal type Login");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Login)untypedValue;
            if (value == Login.Takenet)
            {
                serializer.Serialize(writer, "takenet");
                return;
            }
            throw new Exception("Cannot marshal type Login");
        }

        public static readonly LoginConverter Singleton = new LoginConverter();
    }

    internal class NodeIdConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(NodeId) || t == typeof(NodeId?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "MDEyOk9yZ2FuaXphdGlvbjQzNjk1MjI=")
            {
                return NodeId.MdEyOk9YZ2FuaXphdGlvbjQzNjk1MjI;
            }
            throw new Exception("Cannot unmarshal type NodeId");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (NodeId)untypedValue;
            if (value == NodeId.MdEyOk9YZ2FuaXphdGlvbjQzNjk1MjI)
            {
                serializer.Serialize(writer, "MDEyOk9yZ2FuaXphdGlvbjQzNjk1MjI=");
                return;
            }
            throw new Exception("Cannot marshal type NodeId");
        }

        public static readonly NodeIdConverter Singleton = new NodeIdConverter();
    }

    internal class StarredUrlConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(StarredUrl) || t == typeof(StarredUrl?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "https://api.github.com/users/takenet/starred{/owner}{/repo}")
            {
                return StarredUrl.HttpsApiGithubComUsersTakenetStarredOwnerRepo;
            }
            throw new Exception("Cannot unmarshal type StarredUrl");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (StarredUrl)untypedValue;
            if (value == StarredUrl.HttpsApiGithubComUsersTakenetStarredOwnerRepo)
            {
                serializer.Serialize(writer, "https://api.github.com/users/takenet/starred{/owner}{/repo}");
                return;
            }
            throw new Exception("Cannot marshal type StarredUrl");
        }

        public static readonly StarredUrlConverter Singleton = new StarredUrlConverter();
    }

    internal class TypeEnumConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(TypeEnum) || t == typeof(TypeEnum?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "Organization")
            {
                return TypeEnum.Organization;
            }
            throw new Exception("Cannot unmarshal type TypeEnum");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (TypeEnum)untypedValue;
            if (value == TypeEnum.Organization)
            {
                serializer.Serialize(writer, "Organization");
                return;
            }
            throw new Exception("Cannot marshal type TypeEnum");
        }

        public static readonly TypeEnumConverter Singleton = new TypeEnumConverter();
    }

    internal class VisibilityConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Visibility) || t == typeof(Visibility?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "public")
            {
                return Visibility.Public;
            }
            throw new Exception("Cannot unmarshal type Visibility");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Visibility)untypedValue;
            if (value == Visibility.Public)
            {
                serializer.Serialize(writer, "public");
                return;
            }
            throw new Exception("Cannot marshal type Visibility");
        }

        public static readonly VisibilityConverter Singleton = new VisibilityConverter();
    }
}
