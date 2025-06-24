Return-Path: <linux-can+bounces-3889-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C586AE6F63
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 21:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B376E3B32D9
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08F29B20D;
	Tue, 24 Jun 2025 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OdOK1u58"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CC22541B;
	Tue, 24 Jun 2025 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792922; cv=none; b=N8jMsfareG6rmzD8Zkll4Vud6WG5hzAJuH+VwqY9ks+sIFQQtAMW5Hqnh81YhIWQn4As782Qj71CL1zTVAPiOfhE6jRWJHPuBPXUx0ZgDB1F6Snq73bUFU9qWVUSxR+7scsQQKT3Y5McVwxTyD28ltydP9EBunLwDYmExmAjcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792922; c=relaxed/simple;
	bh=2gHJwhaskW5SUBT5zRRtLU24j7skDPe5IOS025HcXvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmy/3rXOPTGiQkiVyMf0ei20/iHssIQ1o44K/ZCIiy6D+IYQF0UfMdKft6m2aydraR4DIdOKL6R83fy0X2q3GKUejcUPhh3NVrYZsSwImm7OQgK0d+eGJoWpIh1p65KL+T32QCFTcwYCYu5ShK6uHB2rI+I9JMjB3vRXzJKxigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OdOK1u58; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750792916; x=1751397716; i=markus.elfring@web.de;
	bh=ljbEJFYOf65l1dJAx0ggWvXvqYqwuOmut7Zxn+MRviQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OdOK1u58GG9HWzOjhAI2r0jO22vUE20t0DgHQWSGTlSWj05SuS6Uq8JmfXVoDUbj
	 fgwVVWLIfl/wwJuHimtzzFT4esTVoFqqMS+zSh7Fa8kHOL2p17dsgKFPI3PKfimMJ
	 tU2SO8wE5JQ43181yce6Snlidve9v8Qeva928bvPqMhHeab91uluqEQmWZEJVYzqE
	 nCcvrPHWZamVHfP7gQRmlTlBKw/BSKrq93P5Dap3tT4Hmqj9vmJo+slb6HuihZigh
	 OVggz/HDB0ddBhd+Jlu2vo4Lbo1G83aR9bpYbMrrZ1xVIKusrdcC5qP6vy4YElXXQ
	 03DYciCkEd3tSIl50g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.200]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALiL-1uaQcS3NrH-003jmr; Tue, 24
 Jun 2025 21:21:55 +0200
Message-ID: <8b6c8271-c3b5-4950-abb4-5888c3d4c67f@web.de>
Date: Tue, 24 Jun 2025 21:21:55 +0200
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
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q48DxLkcUe1VJB85UsvSNkS38xtCeqA9ZJzpuUS81c6NCjwRVDr
 Nu7Lmz5QUnflO7V3yTjp9es2DANlAEPAFxshwIojm3eLyZS4OTFjlFm+fqjfnpiXGz2xPaa
 2hJiP7OinEuYm1XiUjuFWPr9X02I4Hv6BqVoO365RUc+3cfrEbms9AXwC9MD2wal/Ku8Jik
 H6nqANvBpeloaoNycNd4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6woBtDjd6GQ=;gH9W9V4Ii/KKuzqsdKibhroDVYK
 +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
 BcqXX0D5zJxxbOp0F+CJrD8=

>> +++ b/drivers/net/can/usb/ucan.c
>> @@ -1353,16 +1353,14 @@ static int ucan_probe(struct usb_interface *int=
f,
>>  		ep =3D &iface_desc->endpoint[i].desc;
>> =20
>>  		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) !=3D 0) &&
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^
> This is:
>=20
> 	usb_endpoint_dir_in(ep)

Can the check for a single value like =E2=80=9CUSB_DIR_IN=E2=80=9D be real=
ly mapped to
an other value range?
https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/usb/c=
h9.h#L495-L503

Regards,
Markus

