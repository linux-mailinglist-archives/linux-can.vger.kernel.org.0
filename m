Return-Path: <linux-can+bounces-4114-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD82B116D4
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 05:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B3DAA7F02
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 03:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0219F420;
	Fri, 25 Jul 2025 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JKzb/IKu"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64175EEAB;
	Fri, 25 Jul 2025 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753412723; cv=none; b=qcLXU5GYNOxsdmkSX+IZsmDteTooBU7arKn34j4BkFe3im+GjESm+paDMKuyvENNoZqbat5KoXbu7VyTeb2TBuIiXBEzsTJb+MHFeX3fLypbWSYDEYakpm56flkrWNN3fhqxPEjNsk/dZJkvBJQs1yeRLwI8Y2jOugxB4boBPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753412723; c=relaxed/simple;
	bh=nake4eQNjJwbaaX/FCpGobO+XyGtoFE1MRvsFkkNgaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNk9tud3QNJuw4AKkTODeV1/QUPtX15J+p8aSkX0zDDnazPELFen/FhqbD6eIqdA7+qZC2nG8SkC2fRekrxWGAhtrQdZRR/5CjIXq1x+VyF+uYbz4RIJV0hwOuF9uJiwrlXV76KhC1GR2vxdZbuAfhXtFRzNmfncnONYqgQnbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JKzb/IKu; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id f8k8ufyqycdoQf8k9uLQiW; Fri, 25 Jul 2025 05:05:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753412711;
	bh=nake4eQNjJwbaaX/FCpGobO+XyGtoFE1MRvsFkkNgaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=JKzb/IKuq3jQ5+/RZIMTSI6031eRkpkPmg7KjQcr4ESd6CYQQXClRqxfiY0DkyOVV
	 4ySgvtAKfx+oCm0y+6BgZr2/AicrF7t44z2sSR3b+zez93QcDTMvo4/XnU8r/dxUIW
	 B3PUy6/ZWFUfTGRBCIvwsTJQzo3GKrf6PuvLXa6oPZWhsp9ymOWKQXxa9JtOJejzJA
	 OaIGZ5zD22vbRGFBsDKujRAKgBRGJ8rIWXFchYWNcdNG8pmU/U9++jd2Ss8plN8isH
	 CXrJMenY2KSg1jrQNyMXZpOYrNsoLi7yHx9d6WFGCaL921rfMDJQd2Kr/bTD7OHDtd
	 ALZtp3ugVU+HQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Jul 2025 05:05:11 +0200
X-ME-IP: 124.33.176.97
Message-ID: <5041358c-7146-409c-9e94-0ab1c996be16@wanadoo.fr>
Date: Fri, 25 Jul 2025 12:05:07 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] can: kvaser_pciefd: Simplify identification of
 physical CAN interfaces
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
References: <20250724073021.8-1-extja@kvaser.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 at 16:30, Jimmy Assarsson wrote:
> This patch series simplifies the process of identifying which network
> interface (can0..canX) corresponds to which physical CAN channel on
> Kvaser PCIe based CAN interfaces.

Make sure to address Simon's comment. Aside from that, all my concerns where
addressed, so, for the full series:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


