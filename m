Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5CA2FB9DE
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhASOiN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 09:38:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:48688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387554AbhASJeA (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 19 Jan 2021 04:34:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611048789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSiwzG9v12CmlwVWx06gp4Le3pkLYm57ocpNi5Q6huo=;
        b=Abm2JyEdlAkvhC/CBF/UW+ky2eH/O8xMx+lli5fWK64+bCRP+brRjKlsdVzraN0cqS1huR
        IDm03Ri5Ea6U2YqH76VaQq0GoivRQ4p8C6glJ0Cn+dfRSpsRY2kK3mfnjlW7d0w4+Azm1d
        MxO7W7NLAoAuBiX7U8twc+Ib1z+x1N0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE71CACF4;
        Tue, 19 Jan 2021 09:33:09 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v2 1/6] API: Add FILE_SCANF to new lib
Date:   Tue, 19 Jan 2021 09:31:38 +0000
Message-Id: <20210119093143.17222-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119093143.17222-1-rpalethorpe@suse.com>
References: <20210119093143.17222-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
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
2.29.2

