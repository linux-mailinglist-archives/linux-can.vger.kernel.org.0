Return-Path: <linux-can+bounces-647-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F02B8C8841
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2024 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09371C21E74
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2024 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D99A56B81;
	Fri, 17 May 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sAzn2EV2"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B308BEE;
	Fri, 17 May 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957093; cv=none; b=L2LeyvxLfR3DuP+25LjT30CD9GODqDn2a1fMsZtO+OQessH8SgoD4kwr61mb6VcOVESSDGepIQQNx02x7bxfYIHvB/yS4ekKAiC77xEN10eQhyO8Um3btWeg3/+FJFOSaFla4wDKpTv2kgYPNN1Ift1zDS+psRz9RpXYTcsBo6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957093; c=relaxed/simple;
	bh=+aVeKwNOkrb3tLI0V3LcMqYrP6mqiK5EMZdPc+VX5HE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Dt6M6NX6U8hg/7s2VRxyya5IA9diOAOrH+d9nQ6mmdDBTJYOZ1B6kpXTFJhV6+vzW8HdXZppoPJPtsfdLvyZoLJNwB+4K6vTYoZIji+jc0kBp2fxcY04t1n08Uu/5gikXj8SOXMy/Qq6mT7I52+RgSzAH1CpGpi21DRvqIFEn/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sAzn2EV2; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715957063; x=1716561863; i=markus.elfring@web.de;
	bh=+aVeKwNOkrb3tLI0V3LcMqYrP6mqiK5EMZdPc+VX5HE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sAzn2EV2K3gYDcmAUxz6SNR/oCJQLkgwsfxtPH1jl8wqSWYBNOUcJHBPt29K91Tn
	 pLOO/DBDOqCpHpfkZhnT1fUywr65u0+NsSz0u+aILZWs5pOlUMDdyJe6sT0O4MYdK
	 i0atqq2wpjMSIn/Q3L5otxnM+ZY5teX8ySRHTmLSqimcA14lmWawsdK1Gqm9HbIj7
	 BUcqH3FhH/C5g6y6D5PUXxmdib0bmHKx1mOvOuAi2DsTLAImCJokIedphgAh8Tx0u
	 OkxHnQ1081fZkQUjP/l8oQ7DkGbOiwOOSYYmzdHbvnpDW3vpwONCKBp26+SRLOd2z
	 cy9WvruWe+xHKfR21Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPU0-1sriyS3uzS-00kwyD; Fri, 17
 May 2024 16:44:23 +0200
Message-ID: <b95de04f-a2f8-4564-b9d4-9c09c47f23c3@web.de>
Date: Fri, 17 May 2024 16:44:18 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Kopp <thomas.kopp@microchip.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Vitor Soares <ivitro@gmail.com>
References: <20240517134355.770777-1-ivitro@gmail.com>
Subject: Re: [PATCH v6] can: mcp251xfd: fix infinite loop when xmit fails
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240517134355.770777-1-ivitro@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jQda5thjhQ3+QAQBTzGmnXxok3VeF3AuKuknKXbC7+IM7t+r+bA
 TyEOkBpzU+hrdwFcDAi7NkHzuYemBbBDhFBmYmjemZ+V6Fhz8fwxghf9Kg/o29smoSZKsMm
 Elrw7pVIP+KjcoJFP2N/F1mPcCPSeOL3E/oE6HAGkAFaE79/AOM62uQJ6Cey1cUNZq+IGkP
 fJ7p4oO6HjybBBeP28fLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dsfVgghV4pY=;3XMg0of8EhzPihplMuDL52QZrKU
 Z9uZdUEkcO4ApLZYj+O/swICZ4s2v3CDDp9NFzVXkBDz1JWXRLqnWs0Uc8UJ0zVecPMgTkpDn
 oUp3e5yl2nluOmiECQ0UPyNT4aBQ8773j3R5aTzHXIE6gF1XQKGQuYP8dNevPHsg8X7fCefpY
 MZI/GxeAsOYXtlM3CsNYvEdkul6PG3Gb8H/d52FYHeioxtRts09KNeE2ZGoo48BA6m/gzSQa1
 q4CRFbj9pNDrrdNwQ9grUvZvMumGRpOVvwfBq9JyXv6Dd547viBwCQDlyd59BiLQZXUws6XhB
 4gl1iCkl/5Et65aYsvXXi2ZBWH0efI1hQK5YRWba5dmpeUd0E+0DibVOkaxZpt6FHAaYGnArB
 xVI7BwAmDFcfwMz9Ywgj3Za55OKkkSoiNn6Ytiv7UC/gmKXHhOdMlt6RLy1dOFcVFBT8BPC2I
 jOV9DR6UoRhF2fjpv7BqaSnbMbS4r98SgPyv7Sc4Fey1FD99kanAtACoBBoMuf/SBzEOxhFp7
 EBi8HIOuvmwm3ac5ZcQuxXubkHu6y6TMTS69MnpRm+XgNt7GkGGVItub2Xq1v2Qn/QXLWsf2W
 EWiw/QNJCfcrPzE8LQ2eihLe9exLwe/c/kiJuDCapc/5mNkNNHymGfsLfk0d/V1/0+gq+0jMu
 Jr1KSJyhejqSkZoOxoKsLKHcyKaIfn8+AfPh7f0xIMTxdDxoJhdgmUgoUoGqkC6WmEi6IDqhW
 2tfo/fTqgIvhJ6iER4Eow8wJJt+Nt4FRe1duH2hBOEgu2HRjynov6yNW7+PkXw3X+IcNkvTp/
 KyDb4oNI5KplT4OwEoLNkgF7F1Y+aBYL8TGVE3h1ahlv8=

=E2=80=A6
> This patch resolves the issue by starting =E2=80=A6

Will further imperative wordings be more desirable for an improved change =
description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94

Regards,
Markus

