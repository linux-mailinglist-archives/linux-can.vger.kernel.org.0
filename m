Return-Path: <linux-can+bounces-3452-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D644A9687F
	for <lists+linux-can@lfdr.de>; Tue, 22 Apr 2025 14:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB9618883A2
	for <lists+linux-can@lfdr.de>; Tue, 22 Apr 2025 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275A27CB15;
	Tue, 22 Apr 2025 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GF9c6g0G"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7627CB2C
	for <linux-can@vger.kernel.org>; Tue, 22 Apr 2025 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323413; cv=none; b=NZrUfKddsJq1oP6ZaHrghN9bmRYAZO4EesHb88OpMTKHus55T39vPpCnyMrBtc/cUWZpgHZI6S19AWxkLP8aJP0GB08vv9eTOh23cCcANUKz8qJ0kLjgBCZ/YoTBX4EWLsGgdIxgravnnWYG7+uOklbt2TFSQWvPUsBzK7HXl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323413; c=relaxed/simple;
	bh=fGNLyeO4BXxJMKyZZ4yPheMyeoQNnX3IhT0VrhJTDXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePLB/AhtXVc2ew6kd6BpTDvAyNXS4ZdNG6M69i63B7YZ6wi+KqjhC6BoWD9/1ZAgu8r8CoKU/2VVp3uCdFvyVE/dGTHOEn5QCFFRAO0f0ofhuZJrAONbegJL5XUUBwz61YrcCBrpaJVs/RMgVQyWMHn2W7R/ptvg6UkmTcXPVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GF9c6g0G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745323411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWEUcZNpRvxvDhyq1qMTRtWz0BHHwRO+pXL+E3wMceo=;
	b=GF9c6g0Gs4HBXMZXRbC7/vunxJtK3uYAOqvm3QBqMbie890U/dcoJ0TI+cwf/IG27VHKY/
	XnW34IO0b30PhrIeJCYRw5OpNRzIb5LswxwYfEkQruwZjn2iNgXdypYnROUE05YEQ5828/
	T24gYF+xy0/XzY3C3B6FCVysXy8an9k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-mVKU2dp2MG6kORyZP50FJw-1; Tue,
 22 Apr 2025 08:03:27 -0400
X-MC-Unique: mVKU2dp2MG6kORyZP50FJw-1
X-Mimecast-MFC-AGG-ID: mVKU2dp2MG6kORyZP50FJw_1745323405
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC1951801A15;
	Tue, 22 Apr 2025 12:03:25 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 38A06180045C;
	Tue, 22 Apr 2025 12:03:22 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: socketcan@hartkopp.net,
	mkl@pengutronix.de
Cc: shuah@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dcaratti@redhat.com,
	fstornio@redhat.com
Subject: [PATCH 4/4] selftests: can: Document test_raw_filter test cases
Date: Tue, 22 Apr 2025 14:02:37 +0200
Message-ID: <710557cef8fb8472628862d9b65edcf7aeb32bb5.1745323279.git.fmaurer@redhat.com>
In-Reply-To: <cover.1745323279.git.fmaurer@redhat.com>
References: <cover.1745323279.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The expected results did not explain very well what was really tested. Make
the expectations more clear by writing out the flags that should be set in
the received frames and add a short explanation for each test case. Also,
document the overall test design.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 .../selftests/net/can/test_raw_filter.c       | 65 ++++++++++++++-----
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
index 7fe11e020a1c..8d43053824d2 100644
--- a/tools/testing/selftests/net/can/test_raw_filter.c
+++ b/tools/testing/selftests/net/can/test_raw_filter.c
@@ -101,94 +101,113 @@ FIXTURE_VARIANT(can_filters) {
 	int exp_num_rx;
 	int exp_rxbits;
 };
+#define T_EFF (CAN_EFF_FLAG >> 28)
+#define T_RTR (CAN_RTR_FLAG >> 28)
 
+/* Receive all frames when filtering for the ID in standard frame format */
 FIXTURE_VARIANT_ADD(can_filters, base) {
 	.testcase = 1,
 	.id = ID,
 	.mask = CAN_SFF_MASK,
 	.exp_num_rx = 4,
-	.exp_rxbits = 4369,
+	.exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
 };
+/* Ignore EFF flag in filter ID if not covered by filter mask */
 FIXTURE_VARIANT_ADD(can_filters, base_eff) {
 	.testcase = 2,
 	.id = ID | CAN_EFF_FLAG,
 	.mask = CAN_SFF_MASK,
 	.exp_num_rx = 4,
-	.exp_rxbits = 4369,
+	.exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
 };
+/* Ignore RTR flag in filter ID if not covered by filter mask */
 FIXTURE_VARIANT_ADD(can_filters, base_rtr) {
 	.testcase = 3,
 	.id = ID | CAN_RTR_FLAG,
 	.mask = CAN_SFF_MASK,
 	.exp_num_rx = 4,
-	.exp_rxbits = 4369,
+	.exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
 };
+/* Ignore EFF and RTR flags in filter ID if not covered by filter mask */
 FIXTURE_VARIANT_ADD(can_filters, base_effrtr) {
 	.testcase = 4,
 	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
 	.mask = CAN_SFF_MASK,
 	.exp_num_rx = 4,
-	.exp_rxbits = 4369,
+	.exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
 };
 
+/* Receive only SFF frames when expecting no EFF flag */
 FIXTURE_VARIANT_ADD(can_filters, filter_eff) {
 	.testcase = 5,
 	.id = ID,
 	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
 	.exp_num_rx = 2,
-	.exp_rxbits = 17,
+	.exp_rxbits = (1 | 1 << (T_RTR)),
 };
+/* Receive only EFF frames when filter id and filter mask include EFF flag */
 FIXTURE_VARIANT_ADD(can_filters, filter_eff_eff) {
 	.testcase = 6,
 	.id = ID | CAN_EFF_FLAG,
 	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
 	.exp_num_rx = 2,
-	.exp_rxbits = 4352,
+	.exp_rxbits = (1 << (T_EFF) | 1 << (T_EFF | T_RTR)),
 };
+/* Receive only SFF frames when expecting no EFF flag, ignoring RTR flag */
 FIXTURE_VARIANT_ADD(can_filters, filter_eff_rtr) {
 	.testcase = 7,
 	.id = ID | CAN_RTR_FLAG,
 	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
 	.exp_num_rx = 2,
-	.exp_rxbits = 17,
+	.exp_rxbits = (1 | 1 << (T_RTR)),
 };
+/* Receive only EFF frames when filter id and filter mask include EFF flag,
+ * ignoring RTR flag
+ */
 FIXTURE_VARIANT_ADD(can_filters, filter_eff_effrtr) {
 	.testcase = 8,
 	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
 	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
 	.exp_num_rx = 2,
-	.exp_rxbits = 4352,
+	.exp_rxbits = (1 << (T_EFF) | 1 << (T_EFF | T_RTR)),
 };
 
+/* Receive no remote frames when filtering for no RTR flag */
 FIXTURE_VARIANT_ADD(can_filters, filter_rtr) {
 	.testcase = 9,
 	.id = ID,
 	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
 	.exp_num_rx = 2,
-	.exp_rxbits = 257,
+	.exp_rxbits = (1 | 1 << (T_EFF)),
 };
+/* Receive no remote frames when filtering for no RTR flag, ignoring EFF flag */
 FIXTURE_VARIANT_ADD(can_filters, filter_rtr_eff) {
 	.testcase = 10,
 	.id = ID | CAN_EFF_FLAG,
 	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
 	.exp_num_rx = 2,
-	.exp_rxbits = 257,
+	.exp_rxbits = (1 | 1 << (T_EFF)),
 };
+/* Receive only remote frames when filter includes RTR flag */
 FIXTURE_VARIANT_ADD(can_filters, filter_rtr_rtr) {
 	.testcase = 11,
 	.id = ID | CAN_RTR_FLAG,
 	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
 	.exp_num_rx = 2,
-	.exp_rxbits = 4112,
+	.exp_rxbits = (1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
 };
+/* Receive only remote frames when filter includes RTR flag, ignoring EFF
+ * flag
+ */
 FIXTURE_VARIANT_ADD(can_filters, filter_rtr_effrtr) {
 	.testcase = 12,
 	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
 	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
 	.exp_num_rx = 2,
-	.exp_rxbits = 4112,
+	.exp_rxbits = (1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
 };
 
+/* Receive only SFF data frame when filtering for no flags */
 FIXTURE_VARIANT_ADD(can_filters, filter_effrtr) {
 	.testcase = 13,
 	.id = ID,
@@ -196,28 +215,34 @@ FIXTURE_VARIANT_ADD(can_filters, filter_effrtr) {
 	.exp_num_rx = 1,
 	.exp_rxbits = 1,
 };
+/* Receive only EFF data frame when filtering for EFF but no RTR flag */
 FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_eff) {
 	.testcase = 14,
 	.id = ID | CAN_EFF_FLAG,
 	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
 	.exp_num_rx = 1,
-	.exp_rxbits = 256,
+	.exp_rxbits = (1 << (T_EFF)),
 };
+/* Receive only SFF remote frame when filtering for RTR but no EFF flag */
 FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_rtr) {
 	.testcase = 15,
 	.id = ID | CAN_RTR_FLAG,
 	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
 	.exp_num_rx = 1,
-	.exp_rxbits = 16,
+	.exp_rxbits = (1 << (T_RTR)),
 };
+/* Receive only EFF remote frame when filtering for EFF and RTR flag */
 FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_effrtr) {
 	.testcase = 16,
 	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
 	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
 	.exp_num_rx = 1,
-	.exp_rxbits = 4096,
+	.exp_rxbits = (1 << (T_EFF | T_RTR)),
 };
 
+/* Receive only SFF data frame when filtering for no EFF flag and no RTR flag
+ * but based on EFF mask
+ */
 FIXTURE_VARIANT_ADD(can_filters, eff) {
 	.testcase = 17,
 	.id = ID,
@@ -225,14 +250,22 @@ FIXTURE_VARIANT_ADD(can_filters, eff) {
 	.exp_num_rx = 1,
 	.exp_rxbits = 1,
 };
+/* Receive only EFF data frame when filtering for EFF flag and no RTR flag but
+ * based on EFF mask
+ */
 FIXTURE_VARIANT_ADD(can_filters, eff_eff) {
 	.testcase = 18,
 	.id = ID | CAN_EFF_FLAG,
 	.mask = CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
 	.exp_num_rx = 1,
-	.exp_rxbits = 256,
+	.exp_rxbits = (1 << (T_EFF)),
 };
 
+/* This test verifies that the raw CAN filters work, by checking if only frames
+ * with the expected set of flags are received. For each test case, the given
+ * filter (id and mask) is added and four CAN frames are sent with every
+ * combination of set/unset EFF/RTR flags.
+ */
 TEST_F(can_filters, test_filter)
 {
 	fd_set rdfs;
-- 
2.49.0


