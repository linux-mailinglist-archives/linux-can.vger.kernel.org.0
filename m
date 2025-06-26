Return-Path: <linux-can+bounces-3901-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61EAE96AB
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 09:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569EF160DBD
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61703238C36;
	Thu, 26 Jun 2025 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cO4c5oaQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71EB1DE8BE;
	Thu, 26 Jun 2025 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922574; cv=none; b=YyNxJ+RkAqMMdI9LN5SF1niE8jCs2iNYg8m2ltkN4BAWoa8KJUD2zS9H158KGLb2Ftgc63gS9GCQCURcnIEYl5iZVD6QjYnUrUFv3sQmeskb2xf9QsMZ2hmc6NURnKmNrrH06G8B4IJakyGNZTUeSR/QBZ+GOwRfuc280p0ruOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922574; c=relaxed/simple;
	bh=xn5xGJTDX8CLgN3pQX67e9rZW+ZHFqb9uNcuHUdSfW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pU8A7HeTcFda9xiNFXWlfeKF/M/Il5iwxrv4pDNkfIbH8R9UxQZJ3lulqf6V5edWqJa8BVB4/3bAnNhxZA1z0ZU1tL8kVVRSGvKFLLREOHLuGyJEw6I2ARg3o+UBK/r1xs/hvwnTCAkbOTIj+Mg6jm2trnOr75310D3YBD0Y9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cO4c5oaQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750922557; x=1751527357; i=markus.elfring@web.de;
	bh=hHLsvSh4Eh45XDZ3IR1yDnB2tpn9jxt0fU65TXDdnZk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cO4c5oaQoghtbWSHBByEZWmTN0ok6EMieFRpThEbaIIjpRahWn6k3G1apVDrKXua
	 2YW6LgTNpHHy55TuBvBCaXoSCidA2i1WopvVba07sY35sw7UKNBcNnRfNzm+TjQwF
	 7qcnR1ZEAg9ZIQrVlCwDpErNk/JTm7BM537KkvlV3jGPJHj4fqT0Ma2DsK7m6WE/x
	 /C/DyH063YQnbK1OjzjxOCjsRPCb6f1/zq+13eUR49c0sU1Rt8kDi6d3w2aLg8TAp
	 tCrxU9qoC9DP/iuWLTfbfDnziLOKes08gJnflSAWGv+1wX852jWixiFgnJ34l8wKW
	 4MYiClGougRiIvHEBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.202]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElV3-1uXfrr33sp-004xvP; Thu, 26
 Jun 2025 09:22:36 +0200
Message-ID: <1e64bcef-33f1-4295-b91f-d4598b32b866@web.de>
Date: Thu, 26 Jun 2025 09:22:17 +0200
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
 <7e6f8929-6665-45af-b01b-167a1aa80305@web.de>
 <CAMZ6Rq+PEZWzxNYDODq-Rz_Y8T_XEihyZKoY-MYo6bn5ATaGLQ@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAMZ6Rq+PEZWzxNYDODq-Rz_Y8T_XEihyZKoY-MYo6bn5ATaGLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qH6guRNMh1V/bjtNkPumCT1nFNcmdGkHMRT3zsUqIyKHcDMciXG
 CsLomwRwkSSkbFjMkpyGq+1tQ8SRbQ7QTA/mercj3Zac5bcpdqgJyyx9SuEROgnkAfS1UX+
 RSpr9eFlD/5sXok+u+k4U7YMltjUU9ocHapT5ZzaFXtwnaQISYgud0hIYvFm0xcgPaB7Km+
 xmM+YvhJltMaIv2uUNbMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TsuQJnbwb8E=;Bjg3XX1+VE251eK+w3wW2nr3VNK
 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
 vrfj30+kVZKu50q2JOBZZjKmesn7TaEo=

>> I am unsure if the check reordering would be desirable for this functio=
n implementation.
>=20
> Ah, you want to confirm whether
>=20
>   usb_endpoint_dir_in(ep) && usb_endpoint_xfer_bulk(ep)
>=20
> is the same as
>=20
>   usb_endpoint_xfer_bulk(ep) && usb_endpoint_dir_in(ep)
>=20
> ?

Exactly, yes.

Commutativity can probably be applied in this case.
But the different execution order will influence the corresponding run tim=
e characteristics.
https://en.wikipedia.org/wiki/Short-circuit_evaluation
https://en.wikipedia.org/wiki/Commutative_property

The data processing order from known API function implementations might ge=
t priority
also at discussed source code places in the near future.

Regards,
Markus

