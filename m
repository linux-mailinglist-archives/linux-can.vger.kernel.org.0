Return-Path: <linux-can+bounces-684-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E38D1D23
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2024 15:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BEE2844B6
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2024 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE3E16F0EF;
	Tue, 28 May 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kIrbIrMD"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513516132E;
	Tue, 28 May 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903246; cv=none; b=FRDgHVf4jyuHpplCRigaIvY8Yzeow7KsgwBhLEeqPdjp2TIRbfvv/Id0D+Sd+h795PgZzxZs88+W25lTEvSf6fikZpM2W9mag3Ewu0ky1LTXCP6kuTVR4fuwqmprbdbZQQebyarJ/cOjRgnHL6j1c4RYqRX/8sIJMwELaiDfHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903246; c=relaxed/simple;
	bh=Ik3IwN+16oKPOTbYrZpxc/FCC7z+whSbWb1zyWjb2EQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sToyTMhNEVsQkfW6zg3LkfewKzT5RedHEEac5I2HfFnKJ78LV9q8kh0tMCBOEf5Y7T2p2VC9lhi7UBsCEkzK7sE0o2a7IpZORyGP49PeGZ0XeQTq69lWdYY7YPXetcyUxal2NNaktgA/dqpZWwBItKQyiaMMWLapVJxN9A8iH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kIrbIrMD; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716903231; x=1717508031; i=markus.elfring@web.de;
	bh=fKUmntawbOtctP6yN0b3gwKJXY86nmY0qmcKIIFU+QM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kIrbIrMD8WUlgP/D3vNfip/cTAhQ5k/CFLBUlFRL7gGPDcTgCr6+cCHzAUNL41eH
	 nY3663K9aJG4auNJ3v0pyFn4xDrBhi1gpoeId8mD7JL2Z8RmAHpGBPwNKgJSwjkyn
	 nqjnMJxUE94ChApE6t3bspLnYjGrv6i4GkASmYh+YBKqdHR+bgwh6eQTyUSVam5MQ
	 l9HDnb/8xCVB+tQq6FHP3WGktuSmWDIQ0M3x9F1K3oU3JS2fpTXUAs6xJVrCYUtcg
	 oshDjUHzb6VuGhDN8+9foFZd4BnhIrlqbhH+BglAZNGzHYWNUoDvID68p3V+qQA1p
	 PDlHNcUCJ9a4Ol6+Tg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCz1-1s3OO42CLj-00J6fC; Tue, 28
 May 2024 15:33:51 +0200
Message-ID: <799829a9-0061-4e26-a678-ed1e180bfadf@web.de>
Date: Tue, 28 May 2024 15:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Robin van der Gracht <robin@protonic.nl>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 kernel@pengutronix.de, =?UTF-8?Q?Alexander_H=C3=B6lzl?=
 <alexander.hoelzl@gmx.net>
References: <20240528070648.1947203-1-o.rempel@pengutronix.de>
Subject: Re: [PATCH] j1939: recover socket queue on CAN bus error during BAM
 transmission
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240528070648.1947203-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/MGXPLipIr/QLxKLMjXmGzy0bu0p1jeg0nhf3Q1y6odsN+g7S2G
 1+jyAY6AASEQ1VUyhHAguwk1lTShv5VD2RnPus4/FOPDtpOjgM3x0DwTEMyJmBsLdbK8afM
 ic4Iit1Ib2bZGJLHtngpEaDFgD/4LbXN9lEie5tVYv7abbUrBacGgzYvWWSi3j46UvijO/6
 iDw9E/lJwCP7tmaOKzvuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jGP6vXC3I/A=;FWpa1WiDXjnDhxnGscHZLMUwTDe
 iUyyJ6NssagF63SER41bXUFxiqAXcU4FAQJom55FRThQ1r/yULNhalTK72iNx0/Y9cpQ50vSs
 0UyiBidp6KTs32zwuv6zAy6rCPdVe12XZHGbboVBWpb1yJd21bsFCA9hGfqX70/fIx+XXYzwi
 Y+S9uyrOvrGT9kyjO1GoVMFZiWw8665frmDn8i8NPNKVfeeT4/fCUY3D3gOYqn3zL25h7HwBr
 wlDtDL21N8KGhTmL5czlSvflnnE6+s12ZWbtDoXHKXkV5ScH1J/HE8oS3fWuR2Jherym9VXCW
 DkRfV3ye5lqCeVQm1QuhSWXlWhrill9xezwWSwKH3Y3P77gwDdELiEf6D+S6MB6EgE2mEz03r
 tzm8RMD6NreqR5/KEnDHl/kWINN2ftdPGsG2HeO/pK6i0KYpXNQjdub0xs0I0VJzygMIjNSrU
 tLMPuOhl82zZb3ppaEoNWolIvgLzS2aE11eZLswBnXmQcnPbZUAHh16GEamKc6XLB94mb0R8h
 aQDbk7anIMQzjUGdKr+RWp35VQy5EhxpnAjJL0fUrzULPYYjsuHPBQspwsjbROTf7B0imCRdd
 btgqxndj/0MBnJSz9IxwTPXi9x2RDWmpsga2PTkX7luX/2BUCeyknCTWXSKUDowEETqBVgzlS
 D5YGJj6UxjndM1Cbw5is8R/vrxMvw7CWo/aGdOC4ZqLFb8l7M/v0TyOTAW+tcLKCtn5C1+hf/
 1sRYDDhUUy2tag+4bAm/zwbQoyBa4mgRPT6J9cUexv9i0q/gQ+3jvf+k400qXAusbWFqIYRVW
 iqRSaINjD8wvRRTYE37PbtTnstiCopPQ1j/Cw82Xh4RzA=

>                      =E2=80=A6 The fix activates the next queued session=
 after
=E2=80=A6

Please choose an imperative change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc1#n94

Regards,
Markus

