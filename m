Return-Path: <linux-can+bounces-7985-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7cpuGPlxR2paYQAAu9opvQ
	(envelope-from <linux-can+bounces-7985-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 10:25:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 408E470006B
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 10:25:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=ezFfDmOf;
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7985-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7985-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7C2630A1ECA
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09FA371D0A;
	Fri,  3 Jul 2026 08:01:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC636F90F;
	Fri,  3 Jul 2026 08:01:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065708; cv=none; b=mQSPFKFep2oI9TDhY9IsV6RWK8YfhxZ7w5qQfpyKuKIU1I+dz/RJp62JoCu4zhKS3Mu9gXexj2kYYReojq9nYp2HDwhi7XSsLUcIK/TGoi7XHNG6LOi6hQG/x1isLbjAP7COas7zBPEB/u1J2fXKubKaskUM4RtPqtwCztUn0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065708; c=relaxed/simple;
	bh=ew2brvOSYmN1ky2D8NosJqzmW3szyey/bOJzq3A82QI=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=IdosWrNJYmS421doSlPCGv56wI+WaxvxYfPwWFtXIcbE6OylI4xYozveDcwjK7l9PnevCXsrpO0+CYKK55pXxQfiU5sw5LmU96qzxRGWAtZvHgFCYIsAVuqFZ/Aod4xdeTh2r56CAO4oLCOZLZ/mJIDbsxj3OdIAENlL5+Jgi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ezFfDmOf; arc=none smtp.client-ip=203.205.221.240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783065702; bh=Vz7yzuowqwsGsfyfQvMihkNn4ZFIprdXXMLcR6PYob8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ezFfDmOfiJ4ou7W/U2hJb+ouJrYJEzl81BgrYZEFvrlZucZ+8tdZPeHP2URykxA71
	 sftmATKtWYuEZ2D5Y7JvrAHeEE+OgasDPuT5JoJg6x5Aspq/WhkOiHwL31tqueXRid
	 x2y8Z0yhj19WD/KyJh7ZrIByI5C/CYEDmubnQN2I=
Received: from ubuntu2204.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 6622C6D; Fri, 03 Jul 2026 16:01:38 +0800
X-QQ-mid: xmsmtpt1783065700tirs5w4cp
Message-ID: <tencent_EF20BAF99D37B9D3B0C9FC254C8FAC04680A@qq.com>
X-QQ-XMAILINFO: MZm6DsGys3GE89fBSYkiG8al5cm8bYe//WOFdA61HGbH735gchRTefnf6nayMC
	 Mh3xrcox3ACW8m/rWFmIBnvBMGrYQ7UePS/AHnbzg3wfCqQshQgr8CC0gwmEBzLCdnuAPSLZVNtS
	 R/FkC8G+8LEBOjqsMwcCj2db0EdX1MbIQNGjZck5qT9wSWJahd5tKP+cmma5AqkUV15blviwsSbL
	 rz+9ukG+EVNvr9npjeJ56rAiufXtxDuTjzvr/8JAPt5OfAQnhTalo57P1QfKQ94sgOWG2i652Icx
	 vS5jCCjJex7SoCB1170J8Bw48erJISRcc2DkZvKxo2MJUCWrvPTIUtwx/IXmInqXZwdCnufU0vuh
	 CkY5M+J9uSp/3IwpBP5VmlQzvTcSEzSDSf0YBkv3FF5V8f1xhUHD3FwwX+gO6gQJbV8zGJ48xfPg
	 kHp99FqgaBpKSAj4f6DarQ/4ur2ebPt0gl0YxfVHgVOr46VSqyf7ZHCu/Hp8umFVsZ39t97lx0jR
	 4QvstLpzTlP8mbzGSgRmK+upQJ24E+AySgzueqpKtmmamF74dyRl28impuztFRj3A6YqewAXObxD
	 4XDJdjhjcUJ36nQW0ZjAyH7+JBm2lp6J4ZkInQjXEHHdxis2+GJoLZZr7KiVZdXlnaGvScYWvTsV
	 1sYMS2SSLz7Htfmb6A/hKxmitM9aX8LsJK8fZt1DGkE72zc7lsS393whDLMXll0/TaREaQNiO2Qf
	 /oauuOfmFYaK3Wv1kYlQXUGwuj/CRHL65Qhq2sEGv+k22/YqhcT9IY4pOCWMM9+o9x8NlQMmaRA4
	 4rAWutInWQh4X4/QKDTrdePoEplVcWdzt7Dy4OXC1O++OX0Yx71ut7g24jwVb8uX+mvQNuE77w/B
	 15X+mwqJrt92kWBoxDzVFqZQwxAth4FNk4JIZt2jTNcj24MX35gysPKTNdDCwqkSG2bOsrGQcS9s
	 ge/GbDRjTB72leZvnl0hb7PrH0xHiDYi6q0zjKG+XgU9b1xd6K9tv56CAK6FvmQX64vubgMUVghg
	 dIVUZYKz/ZlZcFWeAs6eUq1nb6urT8/vKr8h7cW6/aRRdhAgAv7LFjuQBsM1rRlUnmM5YA7mi8Z/
	 Grr5tWCAA3J44cKVJ0YsGr591GkdJWPwAaUQIPUi7hpLyGawiiei9MxkhryLw5YUI3yO08WZ6OjN
	 ksWRE=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 03 Jul 2026 16:01:26 +0800
Subject: [PATCH v4 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD
 compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260703-master-v4-1-47d40bbf5fda@qq.com>
References: <20260703-master-v4-0-47d40bbf5fda@qq.com>
In-Reply-To: <20260703-master-v4-0-47d40bbf5fda@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7985-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:1579567540@qq.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,qq.com,oss.qualcomm.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,vger.kernel.org:from_smtp,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 408E470006B

RK3588 integrates a Rockchip CAN-FD controller variant that is not
fully compatible with RK3568v2. The RX FIFO count register field is
encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.

Add a dedicated rockchip,rk3588-canfd compatible to describe this
variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
would describe a register layout that does not match the hardware.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v3 -> v4:
- Collect Krzysztof's Acked-by tag.
v2 -> v3:
- Move the Changelog below ---
- Collect Heiko's Reviewed-by tag
v1 -> v2:
- Use enum for the single-compatible entries, as suggested by Krzysztof.
- Reword the commit message to explain the hardware difference instead
  of referring to Linux driver match data.
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330013..81e2b6dfeb02 100644
--- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
@@ -16,7 +16,9 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - const: rockchip,rk3568v2-canfd
+      - enum:
+          - rockchip,rk3568v2-canfd
+          - rockchip,rk3588-canfd
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd

-- 
2.34.1


