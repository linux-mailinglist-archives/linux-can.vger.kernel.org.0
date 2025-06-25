Return-Path: <linux-can+bounces-3892-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E15C5AE7675
	for <lists+linux-can@lfdr.de>; Wed, 25 Jun 2025 07:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026891BC3695
	for <lists+linux-can@lfdr.de>; Wed, 25 Jun 2025 05:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A71CAA82;
	Wed, 25 Jun 2025 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ft7xtHfG"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720C15689A;
	Wed, 25 Jun 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750830490; cv=none; b=XHRDSHh3eun7A66pD+6N7oyOZm/BW6nWKIr8et8N70fYOntqh9jCbVAzTKkJQNtDO7cgJACRj85Rqbhybwyq9lyuKibFsqhQP7cHgweSHDkLQkDMP7YY20n+l6accbDMz4gcAYE282wkpQP8h+B2wdZ4g3R0gEPqjsInGLFwve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750830490; c=relaxed/simple;
	bh=LwfeZ4YBfbX7u+XCuXRkWJ4I8hEJvbhkLjT3MWWuIJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMYudNKtaW9WP1JT1O78gX8VSigECPtghjVE+PylRaGK9Cup8wmywAK81EYHgndN9N7judl3TMLjVV94N8eijjTNO/72cAY0YVxejvDjprfSIOmUDhoszG2eHWZ40dK9+l1sZ+S0/3plj2tE7WAG/NxUWc0VMMSQ+F+IeFkhg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ft7xtHfG; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750830473; x=1751435273; i=markus.elfring@web.de;
	bh=Eg+6z0gZx1emXMQzNuPhRP+ehkS8Nrhi4jLASNM+jJY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ft7xtHfGz9gC0k89j8p5wW+wjfIpnEI44VsBriOlGQrb0wu6yCOjDOvij5NOCA2/
	 M4s+gLB0yS2HW6iIVMZatsoWuFVK1ID9SkgG6gX5yQjO8bjlprc3e35Zw7zU8zzBI
	 96pv4xvJTY1rJYAHv/Y/5E0/LmVQpc5Z7RZjXsMlpXw/pSFMh+j6+jAGaXRJRSUu0
	 QIaElYz2qo2V6jEiXfRMwrHDTmdqsrigrj8PWwQbDT9GsfUE6NHCZLGntp+Dgct2t
	 pAw2BgXmarcuHET/ArnvolOVw2japModSxIniYZ5iHy8N+L1ZLtbtJ8ez0VB5bh8W
	 9ajBCOA9EDjvt1Q8Qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpGw-1v53n10ewE-00aarE; Wed, 25
 Jun 2025 07:47:53 +0200
Message-ID: <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de>
Date: Wed, 25 Jun 2025 07:47:39 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: ucan: Use usb_endpoint_type() rather than
 duplicating its implementation
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
 <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
 <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xRcDTO9kEmM/LF+y8d6p+q9dpRhZnci3IBmLjUFjMhU9iUtsbPW
 j9OnPMmng6YYMaPsbEEikbx8zSUXtVLc3H5MPnT9JXWi3PF+VScn3OJePci6PxWy5O84bej
 82/ZXTqVY3H2pyBY/wo7il2NdWtQnZXgxBqDQ54S0vohGQxQldxA6zH1z4Z9hinUilJFauJ
 wFEhslpQrEpez2BRqSpBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TdJv0ryx+iE=;YBnUdEcqkjFd2agGqoSEXjS8MZW
 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

>>> it seems that Coccinelle missed many simplifications.
>> Would such software transformations become better supported anyhow?
> Maybe?
>=20
> I am not involved in the development of Coccinelle and thus, I don't hav=
e an answer.

This can be fine (in principle).


> Nor do I have the time to read and understand the Coccinelle source code
> to which you pointed me to.

I hope that more users can become interested in presented information.
I would appreciate if knowledge representations can be improved also for
better automatic data processing and corresponding transformations.


> My stance is that such static analyzers should never be trusted 100%.

This is generally fine.


> The output is more an indicator.

This is usual.


>                       And in this present case, a quick review made it v=
ery
> clear that Coccinelle saw one simplification but missed two other ones.

Would you find another source code adjustment (like the following) more ap=
propriate?


diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 07406daf7c88..6c6cee3895c6 100644
=2D-- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1352,17 +1352,12 @@ static int ucan_probe(struct usb_interface *intf,
 	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; i++) {
 		ep =3D &iface_desc->endpoint[i].desc;
=20
-		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) !=3D 0) &&
-		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
-		     USB_ENDPOINT_XFER_BULK)) {
+		if (usb_endpoint_dir_in(ep) && usb_endpoint_xfer_bulk(ep)) {
 			/* In Endpoint */
 			in_ep_addr =3D ep->bEndpointAddress;
 			in_ep_addr &=3D USB_ENDPOINT_NUMBER_MASK;
 			in_ep_size =3D le16_to_cpu(ep->wMaxPacketSize);
-		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) =3D=3D
-			    0) &&
-			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
-			    USB_ENDPOINT_XFER_BULK)) {
+		} else if (usb_endpoint_dir_out(ep) && usb_endpoint_xfer_bulk(ep)) {
 			/* Out Endpoint */
 			out_ep_addr =3D ep->bEndpointAddress;
 			out_ep_addr &=3D USB_ENDPOINT_NUMBER_MASK;


Can the functions =E2=80=9Cusb_endpoint_is_bulk_in=E2=80=9D and =E2=80=9Cu=
sb_endpoint_is_bulk_out=E2=80=9D
be applied here?
https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/usb/c=
h9.h#L572-L595

Regards,
Markus

