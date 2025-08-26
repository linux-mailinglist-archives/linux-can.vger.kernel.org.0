Return-Path: <linux-can+bounces-4374-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3AB3537F
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 07:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4684C3BA2CD
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 05:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6961D2ED87C;
	Tue, 26 Aug 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bJknpB5i"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573742050;
	Tue, 26 Aug 2025 05:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187076; cv=none; b=X71HJK/Pdklml6jEv884iPsFOnpkPqm/EEFgDV6v38fZrqriWOI3IUNTfD3iD4Kr6YlgoKZS2lQwQaM5Rk+BCREMGlVMWwRUavCRzXZoY6mgL/6ULfqL5AYbvwxwNZqik+9dgEH7vGs/FWaJuk3AJvvzdVQa+SGEGHK6+LhdwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187076; c=relaxed/simple;
	bh=i48BSItv42uQcJpDTwNauU/hSHxUE5Tcjx6CkhfYgnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGdOoIBebvuDryHribvCxruqF6G1uZEUi+ezV8U5XS5jowJLv8IFWxlopSSLyGVNVCcckpEf8XTDzNA6KiAv/nYdi9rvNs6/Ty1NrcD6twJdEUP3oK3uUzrQLyGok3tizUnqGHfkwY0SxuQXrQu3J7Pt66DA+Ce9sJSeX5ivrhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bJknpB5i; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756187053; x=1756791853; i=markus.elfring@web.de;
	bh=oUucUWpDJpA2Qbj6/CgVP6kIrGSApkmPt5XPiLz4UJU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bJknpB5iVPkY2txpOK5jk91VocSyeK1XGILgYKrQrO+pR5DdDnDnBng2dI9/dH3n
	 30f0bI+2PtPXlBbICs8R/go1qcx8yor/iNJOHW1i3Dy1vqDinbP49fm1vf4Bpf072
	 J7VNxvS2nr0Ofk/hY556pT+g4pCUezyw08gIE5JZBU4lGylsgOOyjoKlL6xxo4Zng
	 5EpxuZGY6mi0orvlwrmbDzELe5wd4IZ0aB0jTa9egV4yh8htWcCUr+VdXm0uUoSyJ
	 ahkwAJmIAmWhNvcWBYVT9+QCjoZS09AulL32rHmt3nBcjBxo0eTsURY0QfoghV8wx
	 4puPpK3Wo/zauhWOHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.219]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sBv-1uRsGI2CBr-014CAg; Tue, 26
 Aug 2025 07:44:13 +0200
Message-ID: <735d62ba-51b5-4dc2-a8e4-0701ffb01f9a@web.de>
Date: Tue, 26 Aug 2025 07:43:33 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: m_can: use us_to_ktime() in m_can_set_coalesce()
To: Xichao Zhao <zhao.xichao@vivo.com>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20250826025131.112900-1-zhao.xichao@vivo.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250826025131.112900-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6rWRGN3yV4GzOLHib38FTMXV9TqOnJKtLOsfL8mzeK/D1Dziyfs
 Zba7Q99bRdMiw6WAWrd9hFRzsAF6c8S8lQm6zcRzcljVt81o1j8jYWDFQy+pLLsZX8Z72sk
 UhZqcd3kVMP1uGEDrj0l1+cbaZRp4E6F/4QXjyqvuQ5OWdjVn9HVC8r5iAEHq0djAAR6MYC
 8wyjmyYs33OC8Myj0PmvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:trCDvxehrac=;HlbvQBAMY7wr3sSb1c/J2qujeoM
 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

> Replace the if-else statement with a ternary operator to
> set cdev->irq_timer_wait. Use us_to_ktime() instead of
> ns_to_ktime() with NSEC_PER_USEC multiplication. Simplify
=E2=80=A6

You should occasionally use more than 57 characters in text lines
of such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc3#n638


Will an enumeration become helpful here?


=E2=80=A6> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2211,13 +2211,9 @@ static int m_can_set_coalesce(struct net_device *=
dev,
=E2=80=A6> +	cdev->irq_timer_wait =3D us_to_ktime(cdev->rx_coalesce_usecs_=
irq ?
> +					   cdev->rx_coalesce_usecs_irq :
> +					   cdev->tx_coalesce_usecs_irq);
=E2=80=A6

I am curious how coding style preferences will evolve further also for
the usage of the conditional operator at such a place.

Regards,
Markus

