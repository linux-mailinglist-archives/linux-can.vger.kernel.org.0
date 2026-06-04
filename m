Return-Path: <linux-can+bounces-7758-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aWCXOeoCImpCRgEAu9opvQ
	(envelope-from <linux-can+bounces-7758-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 05 Jun 2026 00:57:46 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A67643E13
	for <lists+linux-can@lfdr.de>; Fri, 05 Jun 2026 00:57:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ny1bTZtc;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7758-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7758-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FB953015A8C
	for <lists+linux-can@lfdr.de>; Thu,  4 Jun 2026 22:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3A3033FD;
	Thu,  4 Jun 2026 22:57:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6D2EFD9B;
	Thu,  4 Jun 2026 22:57:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613860; cv=none; b=ExWip6hNpJPGPEzFVISm8xbE9T8IqDhzGK25dLgaylz1FziGAvjcCl8ZrwyG2KsRF8Lbv2iyXNJHf64iYUChQquoLnF1TuoGTCnbLZpjZe6TzJRr0ZfwD5GKhI20Y8bV5uZWqYlnh9Gu4I6CPyz4A6co9p7SXsDfTTZLl1xr0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613860; c=relaxed/simple;
	bh=2TlUIBpxSMH+9bGcBFZbe1n6gKi9gIbnhoT2ikTVCJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MfW5LqIxh8TaSWSsbtmhRpJu/J1byuDS+JM5G91ZMAAQA5u5lYkAGTE3C/TC+aVMI2WtppJdcTM9OU9fpqEqetBxZwb2ytvAekwuk9WL06G+k4U0Lc73jg/1AFjL7kzXHqaiamTbPgMf2UwDc4oC0LcueO5nJ2Rq2dXluPz/7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny1bTZtc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E36B1F00893;
	Thu,  4 Jun 2026 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780613859;
	bh=eB8NVASMw6EPL4lglam8dxrHSkSbY4ghGAbIjShoqbg=;
	h=From:Date:Subject:To:Cc;
	b=ny1bTZtcbVbH1dP6DwLhOb+zF7t/xRud2pn0rNiIDF6rQ3V7oaDig7jC/J/+pKdNb
	 +AmriHItOcdJll1+jYEBOHAmWQfjHqcIlg/z1TEZMhg7WIzTF4QtyTLiUbpCJwpDIP
	 720JVgcn0Ehg72rh9bcXOg5orE+qSBsJrAmfQS3EBYeGLAtVALnxoDuRk2qVqN1oRX
	 y2J32UBuK4NSCgPnypqinWt2H5YIqgUajVBgnM0Bg4gDpLIlrRvwUdsr/xvseAwkRk
	 ag5mt7FImb9abTYSmq7oGDLrre1DJDp5TsNzOWK7MdmcPi5uWKO2ktuemg+rtRqHwY
	 EinDYw66qD2Lg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 04 Jun 2026 15:57:15 -0700
Subject: [PATCH] can: virtio: Fix comment in UAPI header
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-virtio_can-fix-uapi-comment-v1-1-199fa96ec5f0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqDMAxA0V+RPC/QiYj4KyIjjXGLYCttLYL47
 3bb44HLPSFKUInQVycEyRrVu4LnowL+kHsL6lQMtalb05oGs4ak/sXkcNYDd9oU2a+ruISWaSb
 T2cZ2BOWwBSnN7z6Mf8fdLsLpu4TrugHgD/P8fwAAAA==
X-Change-ID: 20260604-virtio_can-fix-uapi-comment-bcafa08b4b8a
To: Harald Mommer <harald.mommer@oss.qualcomm.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Francesco Valla <francesco@valla.it>, virtualization@lists.linux.dev, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=nathan@kernel.org;
 h=from:subject:message-id; bh=2TlUIBpxSMH+9bGcBFZbe1n6gKi9gIbnhoT2ikTVCJc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlKTA/uH5s4L8hHfR/7q62fzHL1AoWW7XCWUn9wqzUwV
 OO3tFp+RykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZiImiEjw8pbbGd7Y5MXvJLY
 sU18041Zby9fz/7TcMB0N9ObL6u3nHJlZDjemiJ45aNWV+ARNo1zizk1Hb6bzb7e2q53+RaftLj
 9PxYA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harald.mommer@oss.qualcomm.com,m:mvaralar@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:mikhail.golubev-ciuchea@oss.qualcomm.com,m:mkl@pengutronix.de,m:francesco@valla.it,m:virtualization@lists.linux.dev,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nathan@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[nathan@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-7758-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2A67643E13

When compile testing the UAPI headers with clang, there is an warning turned
error for using a C++ style ('//') comment, which is explicitly forbidden for
UAPI headers.

  In file included from <built-in>:1:
  ./usr/include/linux/virtio_can.h:29:35: error: // comments are not allowed in this language [-Werror,-Wcomment]
     29 | #define VIRTIO_CAN_MAX_DLEN    64 // this is like CANFD_MAX_DLEN
        |                                   ^
  1 error generated.

Switch to a standard C style comment.

Fixes: 2b6b4bb7d96f ("can: virtio: Add virtio CAN driver")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/uapi/linux/virtio_can.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_can.h b/include/uapi/linux/virtio_can.h
index 08d7e3e78776..e054d5099241 100644
--- a/include/uapi/linux/virtio_can.h
+++ b/include/uapi/linux/virtio_can.h
@@ -26,7 +26,7 @@
 #define VIRTIO_CAN_FLAGS_FD             0x4000
 #define VIRTIO_CAN_FLAGS_RTR            0x2000
 
-#define VIRTIO_CAN_MAX_DLEN    64 // this is like CANFD_MAX_DLEN
+#define VIRTIO_CAN_MAX_DLEN    64 /* this is like CANFD_MAX_DLEN */
 
 struct virtio_can_config {
 #define VIRTIO_CAN_S_CTRL_BUSOFF (1u << 0) /* Controller BusOff */

---
base-commit: 7a85231f762aa97b945878abb9a26683486836c6
change-id: 20260604-virtio_can-fix-uapi-comment-bcafa08b4b8a

Best regards,
--  
Cheers,
Nathan


