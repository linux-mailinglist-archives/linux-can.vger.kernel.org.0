Return-Path: <linux-can+bounces-3886-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9755AE6D56
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 19:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31FF1BC4455
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57E298CBC;
	Tue, 24 Jun 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="c0uovWs3"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD1229B2E;
	Tue, 24 Jun 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785137; cv=none; b=iuN2ulmDvNCXYmZB6mHeyvHRoOzI6kO4FKIFLcDh2awkFc7D3HBiz4m3MHW9rl7bV9SKoShTY2tQeDrTgAl98FXPWduB6QKrysZHfsxYhv+RqiuHFw8KF/GbUPs05WRv9upsbLwbAZKCELc/gJySXHHgZWqjHHYZxwia/2PU4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785137; c=relaxed/simple;
	bh=h0sVCfVcOagD0tqsS8gDzpflM/5z4tyqu6989Yv2ido=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=o2BDmCmmXlxW7+KUe6rv/9AsBzMzkQY0ACufTyRtX4fqNdmf4ei4Z9LbM5wJ6bJNSA8Z6qB5ZuuCjg6+WRR0zSvcKWxH8Tf/jAqfCiBt4K+ywewvAr7nq6IF+Gmk2+hq99aZQmLjnIXPU62OK8vork6I0ohGJX0oPMABV0HPpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=c0uovWs3; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750785128; x=1751389928; i=markus.elfring@web.de;
	bh=B735Ywazu7Jc9hstZpZCsNwUvSOwRdqV1I0bmQpE5dU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c0uovWs3xZ9dpJhDyThO6Gxr98V78UrTl/t4vX/oOqnu5mwfyBGFzadPSAAolWKA
	 jEPLH8MKpfVjrfgU8KzoFmIeMKScm9JDCGfGtL0N7XkVb+yBE5ygcZ0X1PJyn2TXp
	 vZC9r2/QWnjt45uoXOIOcnRNOX9zI2PqmtmmhUSpy6uTJ3WTL3uHqTjg8Mc7zf1l5
	 6l9wVsQVNnPNeMSk9hH3Uk7DSU99oJThdZ1jHiNYsXgbOLpXO6Y3sM8ncbRBB20ug
	 N46VEt2wsZMoDEi4ZQu3Ee46Y/OFV5vMuS/27lp8MujPXLrqUnZ+n/c+4xOonCFSH
	 VQxOWjh7ura+6k6r9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.200]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidDR-1uzaCF316t-00qQAg; Tue, 24
 Jun 2025 19:12:08 +0200
Message-ID: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
Date: Tue, 24 Jun 2025 19:12:07 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] can: ucan: Use usb_endpoint_type() rather than duplicating
 its implementation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7K26in6ZwKFagBC5nvenG6YYHvIzst8AAPLoLXHn+pLhlUkAfwk
 reMCXYC7YbZWCNK3YRVRDp0J1f5bqJTd0F1OcpQUhlPxIQDrA1ud7WoUrk+5nZsYPk/pnsH
 H2Mrn9Wa4iLVzrXDkeTKNHPZmIA/1VkWih9w9JXXojj2SI+pxdtxTqbV6u8XMujPIVv0lnk
 I2NsP2Fgh8NhBkAJfNMuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4e5SRqzz0Ao=;8lo5sp1WoxVDiAubV8b9daNEZgZ
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Jun 2025 19:05:04 +0200

Reuse existing functionality from usb_endpoint_type() instead of keeping
duplicate source code.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/can/usb/ucan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 07406daf7c88..3c8dad8bcca4 100644
=2D-- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1353,16 +1353,14 @@ static int ucan_probe(struct usb_interface *intf,
 		ep =3D &iface_desc->endpoint[i].desc;
=20
 		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) !=3D 0) &&
-		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
-		     USB_ENDPOINT_XFER_BULK)) {
+		    usb_endpoint_type(ep) =3D=3D USB_ENDPOINT_XFER_BULK) {
 			/* In Endpoint */
 			in_ep_addr =3D ep->bEndpointAddress;
 			in_ep_addr &=3D USB_ENDPOINT_NUMBER_MASK;
 			in_ep_size =3D le16_to_cpu(ep->wMaxPacketSize);
 		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) =3D=3D
 			    0) &&
-			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
-			    USB_ENDPOINT_XFER_BULK)) {
+			   usb_endpoint_type(ep) =3D=3D USB_ENDPOINT_XFER_BULK) {
 			/* Out Endpoint */
 			out_ep_addr =3D ep->bEndpointAddress;
 			out_ep_addr &=3D USB_ENDPOINT_NUMBER_MASK;
=2D-=20
2.50.0


