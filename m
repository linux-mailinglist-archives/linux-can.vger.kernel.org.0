Return-Path: <linux-can+bounces-3924-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0924AECC2D
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 12:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5DF3B330E
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40CA1A5B85;
	Sun, 29 Jun 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OHOyl13W"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9951A935;
	Sun, 29 Jun 2025 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751193271; cv=none; b=LE4U4ku6pB9qIB1lYgkcSpHBh+KVGAdFLw80gX8WybJCtapm1LvQZTis6S8Ncj/SHezI5/BWIV6PuxQEQtn05zBp3CfeUBZaX+pYS3maTq/bG3/UtteSTQM77oRnrF81ENqaVteaEtcHCBdmZKUij0XqgL7SGdwzo5TKAPK/udg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751193271; c=relaxed/simple;
	bh=V2kpgl6nmI5iTvA+mpNf/+OotM6zkpEw6nFY0p0WagM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfJDUzsDh08XIK2+ZYY2vLwBwUplcOONc2cUSH+LwqvxRebxZPTMYwLgkPaNUiwZzXT9clhxb+FmCPF50TZQB2iSPZm7TjwDEP/SzNQ9A+in3m5sSRKIR0hO+wEN5UJEhu5Lyahi9nTbx6BGOM9JW2dm93vx33KzQ0egQFo6a5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OHOyl13W; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751193267; x=1751798067; i=markus.elfring@web.de;
	bh=4lqBv2a2EMqsRGzofoOxvNyEK7RyDo1cqZxsqW5eTaM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OHOyl13WG/SP97P5qIVs7g9QRtDWdEBt+d7fOJANFk6s+yTI9WDNxB3dwsWXacQA
	 3Fg8Zh3m7+quysMqZWVlTOS/eTFhoy3Mpg+8G2PmAGNiMgI45iX7lZVc/zyoGA3RJ
	 9ERMH/djpD8F/0MNuejF8CqkKSzXZob/HGSnQZhTRBvYHQXrcvLDjfNH7T2OUpjMK
	 9mFvszhYoUg6VNa2rq1KmGzEGrGe7nFImO9Jk+8glqmSh00WbKPB40D+mFe8nWbOl
	 TFuDaoM+PvxIqpovY5zBtuxwjA+W6FdX4q6lCg1qAAfVzEpNf2qkEZHotIdnsN2mo
	 cqqMjMaSl/0e8R7Q0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml4B6-1uzhWw3ewO-00hqWA; Sun, 29
 Jun 2025 12:34:26 +0200
Message-ID: <5cdbd91e-7047-4911-9d82-ee6436d1f9b0@web.de>
Date: Sun, 29 Jun 2025 12:34:25 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] can: ucan: Use two USB endpoint API functions rather than
 duplicating their implementations
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <0a675827-33af-4ec4-97dc-2e4523e41194@web.de>
 <c44cf0e9-9510-4fe9-aa67-edeaa1be6253@wanadoo.fr>
 <1d773886-1657-4a90-87e1-aaaa169f5783@web.de>
 <a545127e-ee1d-44a5-bf43-149f81bda6a5@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a545127e-ee1d-44a5-bf43-149f81bda6a5@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LmTDQ55D21NHlJZGWlEJCihgkrIebi5eajk3aH+WDWYeKfgpx0V
 7TVYuI/ULJRETYBwy3NU9AKLPE0iYFjoyZTRL4zlqcXXbipZw0RF8IbaLlor4WN5sfQL+ey
 LrhJ25D4lHryAQq8UxocLbzbfSHGlyGHxx7seaeEHOnI1W07ngaf+JUGG62pKCzY0p2BVFT
 gHz8hx4/TvdR0nH6u6m6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h/ypqevOyl4=;6U4Y7N5/iEVBG3NJEIlvCftsVLZ
 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
 X4sB6cU7/sg==

>>> Please use the same email address:
>>
>> You may omit the header specification =E2=80=9CFrom:=E2=80=9D (if you w=
ould find other presented
>> information acceptable), don't you?
>=20
> You are sending a patch which has some checkpatch warnings

A special warning was mentioned.


>                                                            and you think=
 it is
> our duty to fix your mistakes?

It depends =E2=80=A6

There can different views occur according to such communication aspects.


>                                This is not how it works.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc3#n513
https://git-scm.com/docs/git-format-patch/2.48.0#Documentation/git-format-=
patch.txt---from


Regards,
Markus

