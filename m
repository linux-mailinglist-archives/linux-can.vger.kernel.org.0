Return-Path: <linux-can+bounces-3922-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 058B6AECBA5
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 09:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8881A1897FAE
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A269C1E47B7;
	Sun, 29 Jun 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qq6mEzmE"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881A4A0C;
	Sun, 29 Jun 2025 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751183528; cv=none; b=iacCdUGz5uTvyGyhaoxNBElsjbFPQvgY5KnoEzUy1l/gPYML6HwkwmXafeFqPXJ9wusl2JkvCN9PLZ+2Z4B8iaL5Ye+RMpN0fJwyx3AgGZsGi7KwyHSeFchTqEBiE4y1X2a+DP00Zf7GTlPHLmRBZfj0nd1EsQpybhaRwXM/9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751183528; c=relaxed/simple;
	bh=a523bBncyWxkHbsr6EQ+VMxtKb7B6sIbgTccpIJYqWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoxCyNDalifkTD5qf/jnwRsmXYf8jAYfwriMt8HbiFQ3xLnaE3Yk7NKDj19B0lCLDBh2dUhpWKROiTjAD/ZtpjXuIVL6TzjSwoCO/fHkBiy69Ys9y9+9QS4G/t4nzqVuS3OI11HmbTzvBfL7E6XP57lJ/kj6WAASTNV69jTZuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qq6mEzmE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751183509; x=1751788309; i=markus.elfring@web.de;
	bh=a523bBncyWxkHbsr6EQ+VMxtKb7B6sIbgTccpIJYqWQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qq6mEzmEBPhdu6SIqhsgDkHE5oUnX7L95Cc5wIAOf/KzGyQLhZ0ozm1mG/ZjyKEQ
	 M9Ce1zTqNULbnreKdmyfd1YFfuMFDwk6wWBxG7z2hbQd9OoZyjQ/2JQhNtKGeyCvr
	 y8jfK1X+6EIf6PPMk8BXaUDUezoT536PGTzT4NdybagL4GwJ9GEdGeimOtlGKj7DD
	 xRIX/F5Me3iTEroOLo/QqyxVFORtRU1Ew9cTIugtz+7j3x3InuysJxnTXRvIRfdsN
	 mkM4mucXzMep0RIRFB2uEKCr4fLsLqAoTo6zgcLCXfq8pkG7r6Sej+dEelsagSDN/
	 b440f31o4jWuOHI9LQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoeYH-1v2say2H6H-00c3GN; Sun, 29
 Jun 2025 09:51:49 +0200
Message-ID: <1d773886-1657-4a90-87e1-aaaa169f5783@web.de>
Date: Sun, 29 Jun 2025 09:51:46 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] can: ucan: Use two USB endpoint API functions rather than
 duplicating their implementations
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>
References: <0a675827-33af-4ec4-97dc-2e4523e41194@web.de>
 <c44cf0e9-9510-4fe9-aa67-edeaa1be6253@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c44cf0e9-9510-4fe9-aa67-edeaa1be6253@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:turRmltKEg49GvxEDq7nP9EEWuofuC8H1leGJWDYUHWNzuIA9DL
 xNofLHRT/TxIZPhQi2KstVRbT7+aotRws1PsVAtwi37RFFos1Cyc5WySfPFCaYWuZO1zxIW
 NxzyOMTeVRqqu0FZy0jToYxaot4M26r18sTHDRPvrCerTXOv7xNvCOExYF8BBiYTXET1Yqi
 ZC1zbFYKaH40vcg1EDuNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UIq1n8BnK9A=;soP1D+Lj94x4vp4/7rez9X2dzvG
 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
 XPG7KJUeR5g==

> Please use the same email address:

You may omit the header specification =E2=80=9CFrom:=E2=80=9D (if you woul=
d find other presented
information acceptable), don't you?

What does hinder you to support additional email addresses better?

Regards,
Markus

