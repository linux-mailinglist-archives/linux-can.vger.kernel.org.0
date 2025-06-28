Return-Path: <linux-can+bounces-3919-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D5AEC58B
	for <lists+linux-can@lfdr.de>; Sat, 28 Jun 2025 09:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F97016CBAB
	for <lists+linux-can@lfdr.de>; Sat, 28 Jun 2025 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D69220F4B;
	Sat, 28 Jun 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oLmpeDkh"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB267219A8E;
	Sat, 28 Jun 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751095243; cv=none; b=D8cJgvRIjnTh9umeZK3WVbzmLeEG4iC635gK+YphN4zmE1BQq+1AZEU95XJS3DlFXidchz9aSouZSKPe1bMxXEpvp5mis+8uSEhaqQKPVRsIObXgCoJifOo3uKDV0GPYaPYNP08FzXj9pLrSDZcc8XUngBf0X+UPBD4IfNSlfOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751095243; c=relaxed/simple;
	bh=3++kCcv/v0ZzpieMgcwwsyL0Ys0n6vEPLAzcBLp8nus=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TsYDNg0Gpcaogx/943d2wu52CcnRpqBI8x+epFYUYIFO7iHgaIMvbOcvTG41aLpwaAxo8L6jOoW0F+SS7jkU4eTIsnoXB2qAONsT9dDjVXy8qjF4f7FB+eG2otQ/WA7fXhGvoiow0rPJ8WX046urbldkJ4NOn583b9HULzsdaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oLmpeDkh; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751095227; x=1751700027; i=markus.elfring@web.de;
	bh=3GbpxLFPpvGoPLulHdzTH7w3c7HcoYO175+FBn/tj1Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oLmpeDkh7KTX+jCuow0ZwrHwGETbLsDpOuW3biWycDmrX9mfypVRGc+fxPz3bSey
	 GONudYuBYtDmWbJHkEBFcAf86ZQKlcI/hyIXF9fKg25R56Uaod1WXJdqEnsXQl/T4
	 ncXD0y2f1ZGbVV0YP1CMM4UTzkUFQGmM+u/8TcwxjZOMzYvhGJshSWv03Jt4Ta6vQ
	 8IdlepJ7ZxRgBhKe3A22COMV8/e41xRDio0U/MwYYb5/hLz/sjpAVEMYV3kq3DvfT
	 T/5EzM5MASYF/L/fqqdJvsAm9upPuPrYXj4Wcl93qPMPrSjtUw9kHKmzxEMdJu5Qx
	 VaO0yv3d6dHqqxKCuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1v6xae1Ncl-00aPkt; Sat, 28
 Jun 2025 09:20:27 +0200
Message-ID: <0a675827-33af-4ec4-97dc-2e4523e41194@web.de>
Date: Sat, 28 Jun 2025 09:19:40 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v3] can: ucan: Use two USB endpoint API functions rather than
 duplicating their implementations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5nXaE6GR/c/2IuEq8EfJrmBZv9tquHwEXANKoqDL+aIdUtTs9Rg
 e8GbIdL5gHcplHSFB/vB0aBamx4+zq/jtpfMWOHojvzZmTMtu1Y/WJXmPNbBh75gMVIHPWO
 a/yfMUOIA6UF7156HdbQfYUrVuBW2GgMFVHw0SbaRGhMNPaBaZKto0YlpPvRVAcWyEli4vf
 5HhR89heTujCpe7sCwhww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OJavL280Wbc=;QgaArBZuVTBQqF16myASVxiIpV7
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 28 Jun 2025 08:56:51 +0200

* Reuse existing functionality from usb_endpoint_is_bulk_in()
  and usb_endpoint_is_bulk_out() instead of keeping duplicate source code.

* Omit two comment lines which became redundant with this refactoring.

The source code was transformed by using the Coccinelle software.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Elfring <Markus.Elfring@web.de>
=2D--

V3:
https://lore.kernel.org/linux-can/20250626-opalescent-tireless-locust-564d=
48-mkl@pengutronix.de/
* Use an other email address for the tag =E2=80=9CSigned-off-by=E2=80=9D.
* Provide the patch version not as a direct reply to a development discuss=
ion.

V2:
Further change possibilities were taken better into account for
the USB endpoint API with the help of Vincent Mailhol.


 drivers/net/can/usb/ucan.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 07406daf7c88..0935a9b540d6 100644
=2D-- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1351,19 +1351,11 @@ static int ucan_probe(struct usb_interface *intf,
 	out_ep_size =3D 0;
 	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; i++) {
 		ep =3D &iface_desc->endpoint[i].desc;
-
-		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) !=3D 0) &&
-		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
-		     USB_ENDPOINT_XFER_BULK)) {
-			/* In Endpoint */
+		if (usb_endpoint_is_bulk_in(ep)) {
 			in_ep_addr =3D ep->bEndpointAddress;
 			in_ep_addr &=3D USB_ENDPOINT_NUMBER_MASK;
 			in_ep_size =3D le16_to_cpu(ep->wMaxPacketSize);
-		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) =3D=3D
-			    0) &&
-			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
-			    USB_ENDPOINT_XFER_BULK)) {
-			/* Out Endpoint */
+		} else if (usb_endpoint_is_bulk_out(ep)) {
 			out_ep_addr =3D ep->bEndpointAddress;
 			out_ep_addr &=3D USB_ENDPOINT_NUMBER_MASK;
 			out_ep_size =3D le16_to_cpu(ep->wMaxPacketSize);
=2D-=20
2.50.0


