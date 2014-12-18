.class public Ldebug/DebugTool;
.super Ljava/lang/Object;
.source "DebugTool.java"


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "SimpleDateFormat"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ldebug/DebugTool$DefalutUncaughtExceptionHandler;,
        Ldebug/DebugTool$FileObject;,
        Ldebug/DebugTool$HttpClientObject;,
        Ldebug/DebugTool$Number;,
        Ldebug/DebugTool$Object;,
        Ldebug/DebugTool$Task;,
        Ldebug/DebugTool$ThreadStack;,
        Ldebug/DebugTool$ThreadTask;
    }
.end annotation


# static fields
.field public static final _filename:Ljava/lang/String;

.field public static final _tag:Ljava/lang/String;

.field public static final version:Ljava/lang/String; = "0.2"


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 74
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "smaliDebugLog.txt"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ldebug/DebugTool;->_filename:Ljava/lang/String;

    .line 75
    const-string v0, "smaliDebugLog"

    sput-object v0, Ldebug/DebugTool;->_tag:Ljava/lang/String;

    .line 66
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static format(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    .line 79
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "yyyymmdd HHMMss"

    sget-object v2, Ljava/util/Locale;->CHINA:Ljava/util/Locale;

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    .line 80
    .local v0, "sdf":Ljava/text/SimpleDateFormat;
    const-string v1, "%s:%s\n"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    new-instance v4, Ljava/util/Date;

    invoke-direct {v4}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x1

    aput-object p0, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static log2File(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    .line 84
    sget-object v0, Ldebug/DebugTool;->_filename:Ljava/lang/String;

    invoke-static {v0, p0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;Ljava/lang/String;)V

    .line 85
    return-void
.end method

.method public static log2File(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p0, "logname"    # Ljava/lang/String;
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 89
    :try_start_0
    new-instance v1, Ljava/io/FileOutputStream;

    const/4 v2, 0x1

    invoke-direct {v1, p0, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;Z)V

    .line 90
    .local v1, "fout":Ljava/io/FileOutputStream;
    invoke-static {p1}, Ldebug/DebugTool;->format(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/FileOutputStream;->write([B)V

    .line 91
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 99
    .end local v1    # "fout":Ljava/io/FileOutputStream;
    :goto_0
    return-void

    .line 92
    :catch_0
    move-exception v0

    .line 94
    .local v0, "e":Ljava/io/FileNotFoundException;
    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    goto :goto_0

    .line 95
    .end local v0    # "e":Ljava/io/FileNotFoundException;
    :catch_1
    move-exception v0

    .line 97
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method public static log2File(Ljava/lang/String;[B)V
    .locals 4
    .param p0, "logname"    # Ljava/lang/String;
    .param p1, "msg"    # [B

    .prologue
    .line 104
    :try_start_0
    new-instance v1, Ljava/io/FileOutputStream;

    const/4 v3, 0x1

    invoke-direct {v1, p0, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;Z)V

    .line 105
    .local v1, "fout":Ljava/io/FileOutputStream;
    new-instance v2, Ljava/text/SimpleDateFormat;

    const-string v3, "yyyymmdd HHMMss"

    invoke-direct {v2, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 106
    .local v2, "sdf":Ljava/text/SimpleDateFormat;
    new-instance v3, Ljava/util/Date;

    invoke-direct {v3}, Ljava/util/Date;-><init>()V

    invoke-virtual {v2, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/io/FileOutputStream;->write([B)V

    .line 107
    const-string v3, ":"

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/io/FileOutputStream;->write([B)V

    .line 108
    invoke-virtual {v1, p1}, Ljava/io/FileOutputStream;->write([B)V

    .line 109
    const-string v3, "\n"

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/io/FileOutputStream;->write([B)V

    .line 110
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 118
    .end local v1    # "fout":Ljava/io/FileOutputStream;
    .end local v2    # "sdf":Ljava/text/SimpleDateFormat;
    :goto_0
    return-void

    .line 111
    :catch_0
    move-exception v0

    .line 113
    .local v0, "e":Ljava/io/FileNotFoundException;
    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    goto :goto_0

    .line 114
    .end local v0    # "e":Ljava/io/FileNotFoundException;
    :catch_1
    move-exception v0

    .line 116
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method public static log2File([B)V
    .locals 1
    .param p0, "msg"    # [B

    .prologue
    .line 121
    sget-object v0, Ldebug/DebugTool;->_filename:Ljava/lang/String;

    invoke-static {v0, p0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;[B)V

    .line 122
    return-void
.end method

.method public static logcat(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    .line 126
    sget-object v0, Ldebug/DebugTool;->_tag:Ljava/lang/String;

    invoke-static {v0, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 127
    return-void
.end method

.method public static logcat([B)V
    .locals 8
    .param p0, "msg"    # [B

    .prologue
    const/4 v3, 0x0

    .line 130
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 131
    .local v1, "sb":Ljava/lang/StringBuilder;
    array-length v4, p0

    move v2, v3

    :goto_0
    if-lt v2, v4, :cond_0

    .line 134
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V

    .line 136
    return-void

    .line 131
    :cond_0
    aget-byte v0, p0, v2

    .line 132
    .local v0, "b":B
    const-string v5, "%02x"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v7

    aput-object v7, v6, v3

    invoke-static {v5, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 131
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method public static setUnhandleExceptionHandler()V
    .locals 1

    .prologue
    .line 143
    new-instance v0, Ldebug/DebugTool$DefalutUncaughtExceptionHandler;

    invoke-direct {v0}, Ldebug/DebugTool$DefalutUncaughtExceptionHandler;-><init>()V

    invoke-static {v0}, Ljava/lang/Thread;->setDefaultUncaughtExceptionHandler(Ljava/lang/Thread$UncaughtExceptionHandler;)V

    .line 144
    return-void
.end method
