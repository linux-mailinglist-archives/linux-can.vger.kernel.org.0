Return-Path: <linux-can+bounces-3484-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C65A9C09B
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316347A9B33
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 08:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BAD1F4180;
	Fri, 25 Apr 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DJKVm7Um"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA868BEA;
	Fri, 25 Apr 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568927; cv=none; b=kq6ihGUm6V+wXtwvjOUFEWY3bFpvuWb2H6VWzrQZtBIhc2VatD9+WyqfZTF3QqKN4NiRKpUGvJjS+ROefubh/4HXnjD2KYR+lcAi08x68djz+kx40gU2zYCYW/5RLFYVh0QOQR9FOWlb2/AQwNbKije258tTi1VQeb5RcCfp9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568927; c=relaxed/simple;
	bh=86b6Qygih6V8o2xUszx+iWOy8Fak2smPLa/wf8BPUEs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rASbwvfiilkHjRvn4SuAaSlNTXU5skGi49YooJ12QJyHEP0Zo1Kz/o7h03grsT27X+m1KOVexzJLnp/n989nDJ03Bzu5qNpSzc5RuigI2DAdNzEPAhA5k7BG7XL7ia2cBVYOUmsT37PoEWStQaOtdMMPsH6z6TKqsS1eM0bsPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DJKVm7Um; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745568912; x=1746173712; i=markus.elfring@web.de;
	bh=86b6Qygih6V8o2xUszx+iWOy8Fak2smPLa/wf8BPUEs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DJKVm7Um14QBrGI5YF5f6phDVq8hfM7NndJP+Iwp3pF/nqMLMhlYsFTNKYDMHM1b
	 oNtEOPymIsCdWpK4SJeI2XH5hnKnJdyTDbihMRQNw8VDjl53yRL9my6cyC+r/Jrq9
	 tVqnkb0/CttgR/nIH34cFM69nQadk6t5+TnoFWqu2R3uC8paO7s4aXCMjhTYPkEWf
	 ycQVvZ82lf8Tqi4Pk/kS+9zsMMm444EF2RLd1G6A3B0wDOASYFeXVgHEc/o5njETK
	 YOx1kuEYBp1kZ2jrWR+TPo6NYDV7Ou6xCrusPcS0CiG+0mjHiXXdNebVCC/4FfEUc
	 +wPMN89LZozQMb/RoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mo6Jz-1urni70HAB-00hWDX; Fri, 25
 Apr 2025 10:15:12 +0200
Message-ID: <7426e045-d0af-4243-b147-98098dd9015d@web.de>
Date: Fri, 25 Apr 2025 10:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Antonios Salios <antonios@mwa.re>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Jan Henrik Weinstock <jan@mwa.re>, Marc Kleine-Budde <mkl@pengutronix.de>,
 lukas@mwa.re, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20250424125219.47345-2-antonios@mwa.re>
Subject: Re: [PATCH] can: m_can: initialize spin lock on device probe
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250424125219.47345-2-antonios@mwa.re>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UQ/5Rtz6vO/hpJwJp9JNwQWdaF/N/xTJDqhoEq0FoRbPEALdAgW
 9csabdgKf3aJJQEcB+d2BeHLoLnWxtrMtXPsQZrc4/+qqEGyd4EYpIfyMHDWqobTOFfFHBG
 +BZnu1yKA7oxe+OFT0c0UmrqPdgKOlQElgvkuEcCh9dmw9brEV6F3NO+OwpfqG2tIMAiICg
 IFQiPe14aVYOzmLYN7CRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H541I6rwjww=;7hiBvQ0crSkS/OyofSlnRvl+pGe
 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

=E2=80=A6
> This patch fixes =E2=80=A6

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc3#n94

Regards,
Markus

