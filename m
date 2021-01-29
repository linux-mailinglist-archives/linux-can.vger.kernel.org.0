Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C239308AE6
	for <lists+linux-can@lfdr.de>; Fri, 29 Jan 2021 18:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhA2REo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Jan 2021 12:04:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:49950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhA2REj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 29 Jan 2021 12:04:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611939833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwNzYu/zko+kb3h/QEPEZx7QjoRNdXWjweCGRiKhaes=;
        b=gUhKd/TmPj9pjGg1KR19zVIHjf6MwhT32qF4ehmJRoZOR73TjtPZvZfeh5idEZsWFMfB20
        0jiCxHFd+Hcmt+0x7fObK2jzcR71PuIgD4ovgqQ0Q4+cTgGIloe2VD/BB1Y0cS2q5CQcVk
        hjr8/RXdlFgtfvuywJQEkFlfYh7rNVg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93708ACF5;
        Fri, 29 Jan 2021 17:03:53 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v4 1/7] API: Add FILE_SCANF to new lib
Date:   Fri, 29 Jan 2021 17:02:59 +0000
Message-Id: <20210129170305.27383-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129170305.27383-1-rpalethorpe@suse.com>
References: <20210129170305.27383-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_file_ops.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 894c16123..ea8f89263 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -7,6 +7,9 @@
 
 #include "safe_file_ops_fn.h"
 
+#define FILE_SCANF(path, fmt, ...) \
+	file_scanf(__FILE__, __LINE__, (path), (fmt), ## __VA_ARGS__)
+
 #define SAFE_FILE_SCANF(path, fmt, ...) \
 	safe_file_scanf(__FILE__, __LINE__, NULL, \
 	                (path), (fmt), ## __VA_ARGS__)
-- 
2.30.0

