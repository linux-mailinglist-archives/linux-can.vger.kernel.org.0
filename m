Return-Path: <linux-can+bounces-7959-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hgmpBahwRmp1VAsAu9opvQ
	(envelope-from <linux-can+bounces-7959-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:07:36 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6604F6F8B18
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:07:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=le88ryaI;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7959-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7959-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39B48301833A
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DBF3C1979;
	Thu,  2 Jul 2026 14:07:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9D4C6EF4
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 14:07:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001251; cv=none; b=to1EA/3onBi6JISW2Pi3R7YAtaP9tc+RgqFhx8HFzUU675ulS6BcMAowdJQAyWI3rpbT8Zmu4aj4uzjdHoUaIacp2qTh1YQpX75w8m0dYyN9DXz8SjP5GXNusjxEmcYBpr4dPXY2WFjNjuTlE5f7zf7ekKxMuzG3sYLpdfoIF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001251; c=relaxed/simple;
	bh=IdvGTt/N3RyEHNIIN0Ci2nl3TBvehqz56QEruhnSMNc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=UkyZRK4u+eXCOwBOt5vRP0ePqJHAvvG7+v4ecWtICYQHsUGY2yrcbleGFW8MpgA9wC9JmTs1pK4acfMWaBN3I0Lq7svPTWcJq++0hsGsRacDh6RceKAM9wdxMhahyxntaazislQ9x7A4/yNTu3JArp3bFxFF9u76AnwA128N8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=le88ryaI; arc=none smtp.client-ip=162.62.57.64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783001246; bh=68umrRJwjcSl0SyHmvSITSEjDGeABNfJiVRzgwyCTsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=le88ryaITlbvOvp8ujEE3d1I6zilgHtpx/0cHQt74gp+V1c1Qv3WtucayYsbMfyGH
	 pwLiUTG7YzkvJczv1I71B1itLfY0VvL/HCv87mWNLJNSxk1Jq/6ZzRz8IfxTPBIKkK
	 xmEGE9DLg93OfHqSCqUfa0ZMa9TE2pNkCuzqXJTk=
Received: from localhost.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 1D09A800; Thu, 02 Jul 2026 22:07:16 +0800
X-QQ-mid: xmsmtpt1783001239tb38rpwa1
Message-ID: <tencent_3B2B6003D1DE4FB7A984665A062581766405@qq.com>
X-QQ-XMAILINFO: Nb+v+bm9wQoUq/DtgdEc2I6YSo1drC1SRiyFXoRlMe3SZ7e9S1Q7m64zPQrKNh
	 zfpmuPrQiI8OZMGlgvYnz2a5ECWNVj+ivr5ZYWZ+jZ18XHRpc9M8RiiOh+weZ/DEi9KX8FYa6HY7
	 BcJso5jkk4gr4Z4mp9bMZg10L4I42xhIOw0I+c8OvlJisgTeSLJbwzQT9FWCoxQhFcUKTBKT7dAj
	 3SRkxL9a256tr0130WsEJGmlpAv/wzIBMjQunth+rDCrOn5173vbRrxvMVexx4jcgy+4GgGbFOCR
	 K0Y9lHud2/G5noA5lL/HnSyOmHOtdcZeDE1q2hzlUHMtzCL5/DcZt5VcE+AGnmoECT9PAu9C2YBq
	 Qeqhp1UYVSkjwRWjGtg8w9NyxhMYDxFhnL9Y1LPifGwgnkjs37QGGNnO2tiYxKa2+/wodq8QDipp
	 S+JkojC4NngqzDsUwclJsYh7zS4MD2R5UDizIG4DNmblSNDXb40QYrlxzbWBgTXikikUdjqgPMJ2
	 F5BtoLOH6FYx+7jEDc0pFgN4QEsRyo7j6uv9A1JtsQyf5lzk4QuoDgPXDWvm0SFRMdl3o/x8vK5O
	 Fie1jpl7h87MRn/27Dh4rvRYbrGEwYNC1JzwlI9uGhpGqERjnaUp/NbxIFjSa5eBDIQ73u0UPMe+
	 iVi8XKRKhla30f3zmTLw1ChdOIHZkxvx+JuKZjbb7HPhEsO1g/j0TR1EndxqYLmU8m1fqURR2jb3
	 Eaf6ZHl2eH+D5IhyDwhjQCSXBUS1/CTyCtTCkyC6aj+3oLy17c/eTR1vnD99uy1XvKJoEO8DWKuP
	 NSmBSSAYxW4J/4JVtrHFE1kD1bTLAm6x0LotZI3CN7XDyJQ8HEt1au/Hr+oF7hEglYQoj1hfOT9v
	 9vwNNYNtYPK+xwBWBPdR8b0QUU39ob3paKWqeNgu2d705K0nDt/akqWTzhjezGpOFYpoxQOziEl4
	 8sthCSyceMKdfjmRMgsthVcpTpQlPbJWemDhzvQbd2tH17ZxJJ4HRaDyDyiUgSaTVGb7jxk3v7rL
	 tKHiEsn823HEO4/RD0TKXN3WaRggs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: 1579567540@qq.com
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can <linux-can@vger.kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	kernel <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Eric Biggers <ebiggers@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-rockchip <linux-rockchip@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v2 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
Date: Thu,  2 Jul 2026 22:06:51 +0800
X-OQ-MSGID: <20260702140654.2961561-2-1579567540@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702140654.2961561-1-1579567540@qq.com>
References: <20260702140654.2961561-1-1579567540@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-7959-lists,linux-can=lfdr.de];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:kernel@pengutronix.de,m:conor+dt@kernel.org,m:heiko@sntech.de,m:dmitry.torokhov@gmail.com,m:shengjiu.wang@nxp.com,m:pengpeng@iscas.ac.cn,m:rmk+kernel@armlinux.org.uk,m:ebiggers@kernel.org,m:mario.limonciello@amd.com,m:kmehltretter@gmail.com,m:dlan@kernel.org,m:sboyd@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:1579567540@qq.com,m:krzk@kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qq.com:+];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,sntech.de,gmail.com,nxp.com,iscas.ac.cn,armlinux.org.uk,amd.com,vger.kernel.org,lists.infradead.org,qq.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6604F6F8B18

From: Cunhao Lu <1579567540@qq.com>

RK3588 integrates a Rockchip CAN-FD controller variant that is not
fully compatible with RK3568v2. The RX FIFO count register field is
encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.

Add a dedicated rockchip,rk3588-canfd compatible to describe this
variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
would describe a register layout that does not match the hardware.

Changes in v2:
- Use enum for the single-compatible entries, as suggested by Krzysztof.
- Reword the commit message to explain the hardware difference instead
  of referring to Linux driver match data.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml  | 4 +++-
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


