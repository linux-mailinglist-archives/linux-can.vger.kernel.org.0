Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE612FD43C
	for <lists+linux-can@lfdr.de>; Wed, 20 Jan 2021 16:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbhATOvH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jan 2021 09:51:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:33198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390516AbhATOjM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 20 Jan 2021 09:39:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611153460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2j0XbK/1WjIdhU456gkB7ScjrGdsote0niueTWY6heM=;
        b=aajR17uSNHPtQmCvNzhtnlfi6AGrnOJo8Be8WOecBeh+KAeAMdT7QV1RKePB80iQo72Qd7
        ez6dme0WUqL45uwDo3p5qkpJggSsLwP9MWWu7hpv8d37pNBHWYdz4KnK+glLJbflERvZRJ
        mvTOfDrOW7E9JD3dk/1z+oSvmDR5Tlc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1CC0FAD8C;
        Wed, 20 Jan 2021 14:37:40 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v3 7/7] can: Update contact details
Date:   Wed, 20 Jan 2021 14:37:23 +0000
Message-Id: <20210120143723.26483-8-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120143723.26483-1-rpalethorpe@suse.com>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

socketcan-users appears to be no more.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/network/can/filter-tests/00_Descriptions.txt | 5 +++--
 testcases/network/can/filter-tests/Makefile            | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/network/can/filter-tests/00_Descriptions.txt b/testcases/network/can/filter-tests/00_Descriptions.txt
index 55d213456..9623d29a0 100644
--- a/testcases/network/can/filter-tests/00_Descriptions.txt
+++ b/testcases/network/can/filter-tests/00_Descriptions.txt
@@ -6,5 +6,6 @@ information on the CAN network protocol family PF_CAN is contained in
 
 For any issue(s) with CAN tests please write to:
 <ltp@lists.linux.it>
-<socketcan-users@lists.berlios.de>,
-Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
+Oliver Hartkopp <socketcan@hartkopp.net>
+Linux-CAN ML <linux-can@vger.kernel.org>
+
diff --git a/testcases/network/can/filter-tests/Makefile b/testcases/network/can/filter-tests/Makefile
index 29aaa3240..bd57c7fff 100644
--- a/testcases/network/can/filter-tests/Makefile
+++ b/testcases/network/can/filter-tests/Makefile
@@ -14,8 +14,6 @@
 #    You should have received a copy of the GNU General Public License along
 #    with this program; if not, write to the Free Software Foundation, Inc.,
 #    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-#  Send feedback to <socketcan-users@lists.berlios.de>
 
 top_srcdir		?= ../../../..
 
-- 
2.30.0

