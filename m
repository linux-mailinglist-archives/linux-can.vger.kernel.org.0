Return-Path: <linux-can+bounces-3905-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90401AEA141
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190C41887DCA
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A632EB5AB;
	Thu, 26 Jun 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sYN13UTn"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2C2EACE3;
	Thu, 26 Jun 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949207; cv=none; b=Unc1Od4NE/Uqkm1IxFVeE40F322oOOvhEYqDi7L1d2sJ3w9Pz6+NDQrhYORvpPEb9JoZGXh+vTSbIUNfArot4EhF9bBXCzAstKwXJJCzLiA6VZvEmobNRLrRusHVakSw9COny0AXmw/KSFf/hITQDjngJL1H0NmWE3l8uMlGB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949207; c=relaxed/simple;
	bh=0TXAeuIr72M1E3iccaZNVuj4v2u5X5A6qlrnq/rmSW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGWlnYwRy6Hm27AUpfjIRTMf5h9Qicd+FD+ujqk6AszIcTJTzYWDMxvhzGbqheaciGTpKiQMI1j2jdBlxNLzop6+tgb1cALbkaXB9M/SlTC1eZpaR7hG8in2LYh1EGE15pqoAEc0aLymZMZHSnCZHXq8in0zCPrl0/LoG7DOEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sYN13UTn; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750949194; x=1751553994; i=markus.elfring@web.de;
	bh=u5P7/QcsjF0uH++GL6EuasjuGVlJ0QeuR+X4QWr8wRE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sYN13UTn9e54NVwnsWr9eJi4R4RFta8Ms2dA0ZJTTG7x3FuKYKsT3qS6yxuiy43M
	 tyUuTSUsA1IV99lLunUXOgULwZQNvOyzuKRAjTbxeDdwvpReApRVwR57OQxhhC1qo
	 s9e4pHdORHtm9TA/fkoXESJAbN88699Lzuw6Z8CSWQvZri2vTpzugkoQejPUWU1pO
	 BlTwjRtS7TCan5wnW+w03sIvC5Wit+GGqI5JBZlGNd/fzKS2gLKZU++8x1Z82462J
	 AwWo3u3lx6+mdybSRy7VY1G5xLnjGJB1oGPIt7vcjCkdk5Cl4hs3h3OzNxkkX8O3v
	 ueJ7HbFSD9p3xzdvmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.202]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDdyH-1ucoEI45LT-003ryP; Thu, 26
 Jun 2025 16:46:34 +0200
Message-ID: <e70a929f-a5c5-487e-9231-61b5423115db@web.de>
Date: Thu, 26 Jun 2025 16:46:32 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] can: ucan: Use two USB endpoint API functions rather than
 duplicating their implementations
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
 <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
 <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
 <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de>
 <c04376f2-6ab7-4256-8bdc-aa6ff3ea88b4@wanadoo.fr>
 <7e6f8929-6665-45af-b01b-167a1aa80305@web.de>
 <CAMZ6Rq+PEZWzxNYDODq-Rz_Y8T_XEihyZKoY-MYo6bn5ATaGLQ@mail.gmail.com>
 <1e64bcef-33f1-4295-b91f-d4598b32b866@web.de>
 <57815326-740d-4053-8b85-c5e57d7cec90@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <57815326-740d-4053-8b85-c5e57d7cec90@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cnPnYvywW0Sg0h/Oo/SyHrXxHQjrPfUXY0VJpiYBVL3/J8/xwlx
 0VKM9cd0kGSfGuUhopVuPfA+g6faXVh8soKIEKZndwVjYWu5+9+AE6e6b3mifhDXIXc0mRi
 luPHTFZK6WuPrrC1oSWPCQe8vTgvYevacYfgvwh9KERDeAzWyBREN6sy2WfQa+GpBp3GzHY
 KbHl/EagUdEk14XpoysOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A5dZRsET5LM=;5kwEyO8yLuStl8gyET5/1AbHFoP
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Jun 2025 16:34:26 +0200

* Reuse existing functionality from usb_endpoint_is_bulk_in()
  and usb_endpoint_is_bulk_out() instead of keeping duplicate source code.

* Omit two comment lines which became redundant with this refactoring.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

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



