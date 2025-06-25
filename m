Return-Path: <linux-can+bounces-3899-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4795AE89A6
	for <lists+linux-can@lfdr.de>; Wed, 25 Jun 2025 18:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080C03B6FB0
	for <lists+linux-can@lfdr.de>; Wed, 25 Jun 2025 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714429B768;
	Wed, 25 Jun 2025 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EsR4H0Ow"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205B929B224;
	Wed, 25 Jun 2025 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868610; cv=none; b=Wkqxqt+8k3RLAi00i+1A+ygIhRnu+Ywzu5VIR0DVtpVp+Y8yNizTotkeDXN7JNyDI9C6gp2lLTU+j4MuLIHtjisRKeJYZX/tWQ2kCpKW2Yo1zoyZj7eUo1L+rxzN63hktPZcbDDaEG95Jtvp+vVjvj84MSr1ynbm4A8RtQA0Bbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868610; c=relaxed/simple;
	bh=pahHex26HOUO/gN4Ra9QFqX8Ff4cUSE150ANSsJr6M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/Lm/nUb9zf+bmILyV6swUsAaLtZjGfBf/8TTs161vWTQxx5xwfozYwiyYIlFXq98yRJ/EoIkfOMl/tYZchJ1RyvUG0X1kFVmFsG7BDWi7Cdz4tSqYPKvOvfiXVuSEg1LZAQY+rt9L0dTLeOwW2yT5lnarbvrjULeUWv/C/xwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EsR4H0Ow; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750868596; x=1751473396; i=markus.elfring@web.de;
	bh=k/uwFNVOf2kHtk20NwkBpuFYn4pYTCvfzdocwdOvsDI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EsR4H0OwjOjz8558LlLHgGxJ9DDN46HZcG4HZcyd+dD9jDyKmOnGB+x5X6YJEvno
	 g0av//3rHBD1wBdUyssE4PNTV04ug01GgvJxzKigHH4PQCh1e+TCgtwSNjq0K7EbR
	 BqSetpvuzoP3MY1VJ6m1cnZ5j8E4bTkhlkd5fVmioit/+ECL1b7+BcKk2DOBwgFkv
	 x3xnqgmIF6iZo/+JRYrEt1CHgwzk9F3zji4PmzgBmEmaNkpDNWWYXxRkJgOUaluN1
	 nmLcps5GPi8Sj7UU+TdFgcDykObJo//ABRc1IupegxM7rnydQ0RVit3DhMB0Sk8lH
	 mkU45hbmfXDMglXRbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sbr-1uUC3P2FaZ-00FZzf; Wed, 25
 Jun 2025 18:23:16 +0200
Message-ID: <7e6f8929-6665-45af-b01b-167a1aa80305@web.de>
Date: Wed, 25 Jun 2025 18:23:15 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can: ucan: Use usb_endpoint_type() rather than duplicating its
 implementation
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
 <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
 <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
 <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de>
 <c04376f2-6ab7-4256-8bdc-aa6ff3ea88b4@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c04376f2-6ab7-4256-8bdc-aa6ff3ea88b4@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kqXcSaJmb4W3O4n7lgnydNK/7scLtPTya6sg0bL4issGjwrNOfr
 mETEVZ7puYde0f1EVGi6RSu+hkS3JVbNiuhGCF7BtlT1g3eLRb1wE9x1IgIuEZ5z/clm6JZ
 RiBwIWjlHLndNjYJ3Sc/l4QdFZ7kOqgStfKYuSLTRWDPv8kjhwqM/QX4kMAVSw04Y6N+VwN
 YW+w9zfsEPyAg/fGE4oqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0ghpVuMyHsE=;nSKsReRDf+67TfHoPm/PJdNE3RG
 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
 LPPrZ1WEFyXhn4r7jZbULzKubGxud298=

> A real quick search shows me that this ucan driver is not an isolated ca=
se.
> Here is an example:
>=20
> https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/media/rc/imon.=
c#L2137-L2148

Thanks that you pointed another implementation detail out from
the function =E2=80=9Cimon_find_endpoints=E2=80=9D.


> But it does not seem to occur so often either. So not sure what is the b=
est:
> do a manual hunt

Unlikely.

I am unsure if such an aspect would become relevant for a code review
by other contributors.


>                  or write a coccinelle checker.

I would find it more convenient to achieve corresponding adjustments
to some degree with the help of such a development tool.
I constructed scripts for the semantic patch language accordingly.


>> Can the functions =E2=80=9Cusb_endpoint_is_bulk_in=E2=80=9D and =E2=80=
=9Cusb_endpoint_is_bulk_out=E2=80=9D
>> be applied here?
>> https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/us=
b/ch9.h#L572-L595
>=20
> Further simplification, nice :)
>=20
> I didn't see that last one, so glad you found what seems to be the optim=
al solution!
I am unsure if the check reordering would be desirable for this function i=
mplementation.

Regards,
Markus

