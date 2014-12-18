.class public Ldebug/DebugTool$Object;
.super Ljava/lang/Object;
.source "DebugTool.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldebug/DebugTool;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Object"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 171
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static log2File(Ldebug/DebugTool$Object;)V
    .locals 1
    .param p0, "o"    # Ldebug/DebugTool$Object;

    .prologue
    .line 185
    sget-object v0, Ldebug/DebugTool;->_filename:Ljava/lang/String;

    invoke-static {v0, p0}, Ldebug/DebugTool$Object;->log2File(Ljava/lang/String;Ldebug/DebugTool$Object;)V

    .line 186
    return-void
.end method

.method public static log2File(Ljava/lang/String;Ldebug/DebugTool$Object;)V
    .locals 2
    .param p0, "filename"    # Ljava/lang/String;
    .param p1, "o"    # Ldebug/DebugTool$Object;

    .prologue
    .line 189
    if-nez p1, :cond_0

    .line 190
    const-string v0, "object is null"

    invoke-static {p0, v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;Ljava/lang/String;)V

    .line 194
    :goto_0
    return-void

    .line 192
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static logcat(Ldebug/DebugTool$Object;)V
    .locals 2
    .param p0, "o"    # Ldebug/DebugTool$Object;

    .prologue
    .line 177
    if-nez p0, :cond_0

    .line 178
    const-string v0, "object is null"

    invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V

    .line 182
    :goto_0
    return-void

    .line 180
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static logcatObjectIsNull(Ldebug/DebugTool$Object;)V
    .locals 1
    .param p0, "o"    # Ldebug/DebugTool$Object;

    .prologue
    .line 173
    if-nez p0, :cond_0

    const-string v0, "true"

    :goto_0
    invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V

    .line 174
    return-void

    .line 173
    :cond_0
    const-string v0, "false"

    goto :goto_0
.end method
