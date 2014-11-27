.class public Ldebug/DebugTool$HttpClientObject;
.super Ljava/lang/Object;
.source "DebugTool.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldebug/DebugTool;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "HttpClientObject"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 216
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static log2File(Ljava/lang/String;Lorg/apache/http/client/methods/HttpGet;)V
    .locals 1
    .param p0, "logfilename"    # Ljava/lang/String;
    .param p1, "get"    # Lorg/apache/http/client/methods/HttpGet;

    .prologue
    .line 227
    invoke-virtual {p1}, Lorg/apache/http/client/methods/HttpGet;->getURI()Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;Ljava/lang/String;)V

    .line 228
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;Ljava/lang/String;)V

    .line 229
    return-void
.end method

.method public static log2File(Ljava/lang/String;Lorg/apache/http/client/methods/HttpPost;)V
    .locals 1
    .param p0, "logfilename"    # Ljava/lang/String;
    .param p1, "post"    # Lorg/apache/http/client/methods/HttpPost;

    .prologue
    .line 241
    invoke-virtual {p1}, Lorg/apache/http/client/methods/HttpPost;->getURI()Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;Ljava/lang/String;)V

    .line 242
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;Ljava/lang/String;)V

    .line 243
    return-void
.end method

.method public static log2File(Lorg/apache/http/client/methods/HttpGet;)V
    .locals 1
    .param p0, "get"    # Lorg/apache/http/client/methods/HttpGet;

    .prologue
    .line 223
    sget-object v0, Ldebug/DebugTool;->_filename:Ljava/lang/String;

    invoke-static {v0, p0}, Ldebug/DebugTool$HttpClientObject;->log2File(Ljava/lang/String;Lorg/apache/http/client/methods/HttpGet;)V

    .line 224
    return-void
.end method

.method public static log2File(Lorg/apache/http/client/methods/HttpPost;)V
    .locals 1
    .param p0, "post"    # Lorg/apache/http/client/methods/HttpPost;

    .prologue
    .line 237
    sget-object v0, Ldebug/DebugTool;->_filename:Ljava/lang/String;

    invoke-static {v0, p0}, Ldebug/DebugTool$HttpClientObject;->log2File(Ljava/lang/String;Lorg/apache/http/client/methods/HttpPost;)V

    .line 238
    return-void
.end method

.method public static logcat(Lorg/apache/http/client/methods/HttpGet;)V
    .locals 1
    .param p0, "get"    # Lorg/apache/http/client/methods/HttpGet;

    .prologue
    .line 218
    invoke-virtual {p0}, Lorg/apache/http/client/methods/HttpGet;->getURI()Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V

    .line 219
    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V

    .line 220
    return-void
.end method

.method public static logcat(Lorg/apache/http/client/methods/HttpPost;)V
    .locals 1
    .param p0, "post"    # Lorg/apache/http/client/methods/HttpPost;

    .prologue
    .line 232
    invoke-virtual {p0}, Lorg/apache/http/client/methods/HttpPost;->getURI()Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V

    .line 233
    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V

    .line 234
    return-void
.end method
