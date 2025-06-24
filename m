Return-Path: <linux-can+bounces-3888-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1311AE6E9B
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749751BC30B3
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75B2E62B3;
	Tue, 24 Jun 2025 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cWDVajBX"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813D230278;
	Tue, 24 Jun 2025 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789706; cv=none; b=ewzOPj39dyOzfw5ThUn8hwJTE6QOK+WZ2te5vAA9SA4DhfUxVWw1zkqubkuIN66BuBrp8pjTDK65RdwwFmloLn1iQ92In0UueM+ARK4UNqL7VRAHaNNfNa5OBQ25ZHQpKRWR8J+/BRQ2jgbstwEUlaEvMd01/ucO+LGqX3t38qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789706; c=relaxed/simple;
	bh=4y1nE6JPRD/KbbMZsgQNG8J1jgQvkKLfsnhSxTtsBBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEIRFjD1MFbJt/TbNVAlG8EfaRFAu5wzfrrsneBheA7N0uirvzCIwnwMJgpICF8QjJHH1t4dSgoomlwp6bCBHcdiL2vs8k5Dkpotw4VtZiKQ8DePScqA64DiLBl8KiMfIFB9FN7OaHLYM5OYiaHui++L+gYA8ur7ojrD58rZciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cWDVajBX; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750789699; x=1751394499; i=markus.elfring@web.de;
	bh=4y1nE6JPRD/KbbMZsgQNG8J1jgQvkKLfsnhSxTtsBBM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cWDVajBXlEfKKHvl/4Bj1nK4hHE+CJzB5Ao6T0CGVzW7f+uN22oRh/pHaoCje/5O
	 xB2Ws/IbLXed4yoTl/ukWwFtqSVvClGvGCspJI2J6HusmxNsZ7X5DxRmsR8v6/4iv
	 CqHI48t/QVH7F2a2Zu0NCGpNtyoAPrxUuo1QxkZ5vzeLjxyieFlUxp4RMuI3FoGF0
	 zTjlLX2acw03p3KCOMxxha+63OnDOPg6c4LDi3Zfq5CFI5tn0mZghu2j+hu4P6wPO
	 5xOcfncg5UN9XO4XEGOjMtOgiNl9/CsQtk0WeBW1D3vkfC9Q7BPwYD55to2de2FOQ
	 xWjaTs0BrmzIs2Ly7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.200]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vop-1uqBaE1089-00xbi7; Tue, 24
 Jun 2025 20:28:19 +0200
Message-ID: <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
Date: Tue, 24 Jun 2025 20:28:18 +0200
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
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eogUSMfdfyL06eIcE6NZ9gO+a3ORUE7w7oP5lfa2WDczCnt4zEm
 5Kf2pwezQ3oulQ/ZCKtZq83JPUZKAP1sArDiv24iQZ3/029yKPk6uXlb725LDl03es+X0/W
 OUY7UFN5CkGHHSFf2wjNKQOyil8MjvSFlvj3WZFQIahEOEvfqF5+N/8jjS3uAhEglrjTbd5
 zKPTVKqqKp5bEpI8R/yog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4pQOt6DRSKA=;xHjH6PFge6TF5DddpSofkhrcTBt
 OO6pro2Mo01gmGZ3B1k2Ap6pMn7KNdGEL3+NaGsqHsUSha7jc8UoE51WAOoDYIuNSl59ifRPl
 eaEESQtHW+63RNp1yP+yVfQh1En447jYp30NpUXMWyUrJYYkwkAK/BZNLtmqs2rmjVpiHOqgv
 P2UIk/BYynUh28NbcKcBbej9whj2AaZT89k2aBKRFeNEEGT7Smt//AcbFOv6nL3rYbURgmwSv
 ZPruWziZ0zJDWFg9dn6Jz7NKDmZvG0n4rSK6Zyflg9EorjYX7qO1/EUFnXT4KLs8RYDPnzWmi
 96vCusZ1H+HFTcmHPaSUqmvdOT3CoPUhENYhrdyaEKr783BtsTC3pLHVa8k+4pesfuLpRzzRe
 X8/1YKhe40Y9Kc/mRuK5Yquv2o9E3w4wOoZ9W3fj6K+kSze48bsPZ1bmaHzCaokRdvMZstesx
 MJwvQ4/qm+p/t1KHasTQOhiBCrR+9+UGWQ73qF4i5cjD1xsoDYdZY9R84lvjtTDpFNTgta3np
 7x8cAXq1wt1EL+f0pWLsyRVo+giRTq5y8iW/Qd2Euh6swA32nDoNoggS2lVyKLo0L4xgZlsQy
 /sTDuML+YWQpjriTKgSeoRvbw+HgrPP62Uz0areNVlNcoP+ymLI9aExukfc3RP5YRjeD+IPSl
 1SgiL+ZOCvtAyTTsa5lsGCmQ54g8E/Ef5RhnZ9yB/uqmMvRiqSpcJ6Y6/mUZZx3CT0eqyg34D
 QCLKzpPgF4hhkqp9ktbFDHxDx08IrdfC1yY0oEaTdnHLfRWFZZRUlbBiP09rAq+MvVOys6GRA
 mlNXCs7OwUlvBJMsjkktTC6VhnVcqaykIxPlne3yagXqCfFco4K8Ag5KWzkt1wRsq6b28RMy8
 Ar8yyjLZqQSiOIm9zK9tGzvlQyl+4MI1hM7/Xh8SlFDEv9PMJ9GaJNB2lm88mKIM8gmCV/+M1
 +fhpMH/fqWREDIBwCzw7sWPJ7hV6Eo4kk5ZahQRV8CJLV34T253Dsj54Xc0VOLKaTFWJR4tyC
 0YFxgBFD0prmtZwRbUfMmlIxK9q7pyCHFS58d7TpKtL54b5AkrWxH7/wE2rQbpOyQIv6M4Tgl
 WtXZ6ixh1EzkzZbnV20cBqwNx62SdaSDSUALxbJA7gB8+KHdZj4el3HKc/X/oh875+GZstvbC
 rLZLXEqzgehtF0RdaDxDJJVYef1wL5wqFlSbCrAEqVWg/JuX784WNCIsBK6wZ0l78gKFZjtQC
 DNOImje7kXK4KHehENvE6/CEkxb5BRzRD2WqgXg3pn/2GEiOHnEnfHdWMG2bSKcUg7K1CK4H8
 dnYKKsnhn66th716krGmyzxFX4UUkxAr9ft+Kgc0E0/gR2ta9q9Ijxc2I9G44hUjoApq/FIAV
 19sCzklNH76QtKcl1Trg8V4io6i2h+D7qpcDRdc9+bsKGuNdt/ktC7ajenHb+rhuFEkFcaqMC
 Is6IcoPTEsWAe0NRa3yP696bGrNUz5v/7CQbX8f4AU0RqBwvnI1kvnIfC+8m3Co8QwneoCe+D
 dUQM98cevQ12ycN+LT+Gt98nalyj9o183OLZ3y3gpQ0rU9lZ/LR4qUpXXCXT436WFxD7AekK1
 TYlwF+9o7Wmp7WRTwRqrc0wnuG1EWoq2FPBjlccaaEW+/GBiCHtarS/jkhDy4dRXoIo4eEjgL
 geF7j9jAvdRftIWQt+LBc3A7VxAaAQECkgUIeeuievJG0lRdbffwyQ+I8Flcy4y1sg1/PjLrA
 DPGpstqUYeA4dpSBr9MHo8jhPOVnCjWqmg+sL++bvZ/GUUywdBvlE2jxilUagqbbNiuXUDekg
 HndOBuPcjnoaxDg6c0bFARCZ8PULJHgtN2fdxYBuWxAb/WI/eRdbke1GESTkgxToqwnCcNZyc
 SknaL8+xamhVtcHx+ZVtMAGHSx7neZYc+bheGUa1l5BwdbQxeZKV0CdOpmT4iJR2veml9h++L
 QxzVRkRkxZTpqwY2FqSt5E8BK78v5s4IhHf/J67ubjP+7qAjOfVTihNy7BXScCdsr9auGbZsT
 FViI0Ly1Yuc0JCwEizQJrN3hhd6nuhMM97mndR2/Ch9ZSqG/CW0u8Tm7ScG8mKe6q/Ga5WbpW
 BNIfw8IN/RezukrlfbX3sQCogSLZBGq0gjx4eMoxqzuRLUmBepjLcLB+bcFp2ay6KUujLiv5P
 h33x7uSg7kHbFvhSscMosi6av87U4C7lPQBFCTxBX2gq6k3vrRH5hg6Mx1tv/Mtfjo83V2pyg
 3ksrWzxzJe1kCES2hi9pS0fTcZArIsUHeytfmcwYXxQ76CMrNXg8Q6ug5SYZR9XB1xJDiCory
 Ip5NdSGLLUCAan6S6lB0biur6vQM817O2TELNZSy3eg+mZ1hJ4a1GPGQW/rOPl7eWGJ1zDs9X
 2MQij0kfcgC+hHpcjKP/z9NOBYsEvodfwV5cdfqmbnd/tUVoDdVoy6/5nMN34rLQfFnSUzO1/
 Kn2QM6HVevO6S5gIyml2aP/PI/JakzDYZnV+NDrX2+676rImFGvyKBIvpibyOidL2E9QHzQLk
 XYY4tlggOa14lv3U0UWHjg9g8tN72ToVUho8vKgF/cjrO+yINxPv6zcAfnd75A/zlxObzvKQg
 TjdXKpe9n576J4g0CUMztQZLA6O6o9Qmy97t2YYq8AnTpZkfkHfY9W/5mlbKQDHNlJAHuuS4x
 INI5EKBVO0vWhP16qYssyQcIh8/aiVr0EGk25t8YSgnp4K29wN7wVDX52yNsT7peSuwYi2vun
 chaJjzIXd77vIIxYmf7CKjb6f412lwDHB7idXJ4JWIz3Ue8xoHwnDk1F9+Bz5h4g14WehGlo5
 /rb//fIUfz58ULSPhbJnxNUHElliaXG//sxtNu/moiYhM6uAPWVFa/Fse9+UFVaIQjVMM20pR
 u4Ql5dhVx3X2cnr5Eu2FdNV8QJpBqrmGW1DgDBDjBvPFaa3tKkwLDii4Vh9WAm0uey/lzCpHI
 Z0lwdDst3JUoXTSdF5HjUkFFWh8ZsIKH+70Iii77lqqRATxSdUx+ToStJiRDPO1AxKhMkbU6W
 azkkUW5f+QtSdkHdwn/rnorLjUFyUijNHQYSC/gixYa3n61beTW2mDRSvk2kslEJQOlzUp8hi
 rgMiMiQkSNd4XAuGeST7r9ku4U3UyuIyP7YkbC+2auZ4AyZ62x3yis3i2KnrLIIudAqfPumUN
 CKAYuDwW/VPCSUs6WKH5k2R4KNU1E49rwZUHHJ0zqYRXfsc/+kyRO6lVPviGNLlAHZ6L1xKZ9
 J/KTS3ZrVpSqTmbrNXGwR0ZWbqD2ZTS1x2kyQQOlAJA07pDO2TG40wTxh0tcaEiZprZvag0DT
 bwH4qDLPCVxAE/r1/2Jqr9K52ws/Q==

> Looking at the helpers in linux/usb/ch9.h,

Please take another look at known source code mappings.

Passing code replacements by APIs (for SmPL)?
https://lore.kernel.org/cocci/481faa1d-7171-4657-8dc0-c37b153e6eaa@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2025-06/msg00044.html


> it seems that Coccinelle missed many simplifications.

Would such software transformations become better supported anyhow?

Regards,
Markus

