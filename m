Return-Path: <linux-can+bounces-7914-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i/DCJR1xQ2rgYQoAu9opvQ
	(envelope-from <linux-can+bounces-7914-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 09:32:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 141BD6E12E5
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 09:32:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7914-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7914-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48A4E3025C78
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA343976AD;
	Tue, 30 Jun 2026 07:30:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B9EEC0;
	Tue, 30 Jun 2026 07:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804625; cv=none; b=M13SEjAyf5tnNueMaB5laMEroQNSDDy4aYGZ60LaF8iVEFoRd1Ys48qitm4H9lilh15zVshG6QuiHwn442n4DcZ9eYR7O4jGhWw8o9R9CzOoioC/elAbjXq+J0Ku9CNjg/ueJrUrbeqHrUNSabYMULkLlD1jb2MGBkC4F+2lC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804625; c=relaxed/simple;
	bh=VI5GG3z/60fSJn2ej1NgW9bkKNYuR3yXnDzKAMgshMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EkGBfiEM78nTwVukq01FxajPLDlWLEn+v4IBqzneGx+n/A4faqKyn42GmLaxP3MgwMs7y+sxBgSyVJG7IOsQbhmIElfZ4budzLtAEuRvHALPPfqJJmqiMxE1s9nJ6FgyHM1g2i7EsvHIf6Y715FDwjX+YKWZFxH8ieKo5bqobqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from 0042-can-gw-validate-checksum-indices-against-frame-length.eml (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAAXYMOGcENqV6gkFg--.11658S2;
	Tue, 30 Jun 2026 15:30:14 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] can: gw: validate checksum indices against frame length
Date: Tue, 30 Jun 2026 15:29:14 +0800
Message-ID: <2026063009033007.3-ccfa108-0042-can-gw-validate-checksum-in-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXYMOGcENqV6gkFg--.11658S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kAr43AF15CF13uFWfZrb_yoW5uw45pa
	y5AFyY9FWkJrWfJrs2yw48Z3y5Aw48J3Z7G3sxK34UAry7ta4DJF17G34SvF18KF4kCr4a
	9rZ0yF4DGFyDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUxcTPUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7914-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 141BD6E12E5

CAN gateway checksum parameters are validated against the maximum Classic
CAN or CAN FD payload size when the route is configured.  At runtime,
however, an individual frame may carry a shorter payload.

The checksum helpers use from_idx, to_idx and result_idx to read and
write cf->data[], and the CRC8 16U8 profile additionally reads
cf->data[1].  A configuration that fits the maximum frame size can
therefore still access bytes outside the current frame's valid payload.

Validate checksum source and result indices against the current
cf->len, and require byte 1 to be present before using the CRC8 16U8
profile selector.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/can/gw.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 0ec99f6..5911afb 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -318,6 +318,19 @@ static inline int calc_idx(int idx, int rx_len)
 		return idx;
 }
 
+static bool cgw_csum_idx_valid(const struct canfd_frame *cf, int idx)
+{
+	return idx >= 0 && idx < cf->len;
+}
+
+static bool cgw_csum_range_valid(const struct canfd_frame *cf,
+				 int from, int to, int res)
+{
+	return cgw_csum_idx_valid(cf, from) &&
+	       cgw_csum_idx_valid(cf, to) &&
+	       cgw_csum_idx_valid(cf, res);
+}
+
 static void cgw_csum_xor_rel(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 {
 	int from = calc_idx(xor->from_idx, cf->len);
@@ -326,7 +339,7 @@ static void cgw_csum_xor_rel(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 	u8 val = xor->init_xor_val;
 	int i;
 
-	if (from < 0 || to < 0 || res < 0)
+	if (!cgw_csum_range_valid(cf, from, to, res))
 		return;
 
 	if (from <= to) {
@@ -345,6 +358,10 @@ static void cgw_csum_xor_pos(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 	u8 val = xor->init_xor_val;
 	int i;
 
+	if (!cgw_csum_range_valid(cf, xor->from_idx, xor->to_idx,
+				  xor->result_idx))
+		return;
+
 	for (i = xor->from_idx; i <= xor->to_idx; i++)
 		val ^= cf->data[i];
 
@@ -356,6 +373,10 @@ static void cgw_csum_xor_neg(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 	u8 val = xor->init_xor_val;
 	int i;
 
+	if (!cgw_csum_range_valid(cf, xor->from_idx, xor->to_idx,
+				  xor->result_idx))
+		return;
+
 	for (i = xor->from_idx; i >= xor->to_idx; i--)
 		val ^= cf->data[i];
 
@@ -371,7 +392,10 @@ static void cgw_csum_crc8_rel(struct canfd_frame *cf,
 	u8 crc = crc8->init_crc_val;
 	int i;
 
-	if (from < 0 || to < 0 || res < 0)
+	if (!cgw_csum_range_valid(cf, from, to, res))
+		return;
+
+	if (crc8->profile == CGW_CRC8PRF_16U8 && cf->len < 2)
 		return;
 
 	if (from <= to) {
@@ -406,6 +430,13 @@ static void cgw_csum_crc8_pos(struct canfd_frame *cf,
 	u8 crc = crc8->init_crc_val;
 	int i;
 
+	if (!cgw_csum_range_valid(cf, crc8->from_idx, crc8->to_idx,
+				  crc8->result_idx))
+		return;
+
+	if (crc8->profile == CGW_CRC8PRF_16U8 && cf->len < 2)
+		return;
+
 	for (i = crc8->from_idx; i <= crc8->to_idx; i++)
 		crc = crc8->crctab[crc ^ cf->data[i]];
 
@@ -433,6 +464,13 @@ static void cgw_csum_crc8_neg(struct canfd_frame *cf,
 	u8 crc = crc8->init_crc_val;
 	int i;
 
+	if (!cgw_csum_range_valid(cf, crc8->from_idx, crc8->to_idx,
+				  crc8->result_idx))
+		return;
+
+	if (crc8->profile == CGW_CRC8PRF_16U8 && cf->len < 2)
+		return;
+
 	for (i = crc8->from_idx; i >= crc8->to_idx; i--)
 		crc = crc8->crctab[crc ^ cf->data[i]];
 


