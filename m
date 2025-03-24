Return-Path: <linux-can+bounces-3194-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3878BA6DBEE
	for <lists+linux-can@lfdr.de>; Mon, 24 Mar 2025 14:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6C31886CF1
	for <lists+linux-can@lfdr.de>; Mon, 24 Mar 2025 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0BD2505C3;
	Mon, 24 Mar 2025 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bpuE5Nrm"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270A1AAA1D;
	Mon, 24 Mar 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823900; cv=none; b=T8mxrfjE2ywg9GgDi8xY06jdUFrnLkjvHhGjlnk0Gr6oNYTR/m3VgOLGHyCAU6gEi8KP7wvdEiV845LpWx258ZBHScYNWRp8nxI1RWojJ4dpYBeBP/uGlDDDAxNWMZ2OV4vKLa3FwfzBe0O7VU0FRnIsI/bP/eOOJQvX469b+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823900; c=relaxed/simple;
	bh=AZ0c9OIdotHoDebUThp+x5UVtk1mvnXCXWFbvrCj0WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnWtLGQWe29z8s+qn+/7WFhwlIowCw++W6apGAj2O22Cm8stNzYrjuBR+Qeo8o9X6bM1BlyAU2ZqvpwfHotzKXC5IJ2bVmWep/ff3afldh1kOWtwpY/ZX5QckpqIfTwRNhLbJ5fHWWEakdO6hhpQogAnDfipiwyXGftJcM0+pyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bpuE5Nrm; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id wi6atJBomDCLUwi6etz7Et; Mon, 24 Mar 2025 14:44:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742823888;
	bh=Qa5om3v9/K/7zpjm5PKgDCV9u2Wr47TRWbPt/isnl+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=bpuE5NrmWf/UsjAJvVswgv0icGAZ1zyNynsHEzuvm89LLVUx0xIx9BhCFwWp8uKPC
	 Z3/O8ApaxqLmSCFiXI3/b401O60aYYUqXVsW/l5eqjjpwPvNkj1jpnCaJGvpzdt4fy
	 1uI6dECsMxCUronlLn9I5tVTU45CmFvJS6GK76XglxdP60k+zO72JxoAyntyWugfkF
	 2+daiMQ91FhVaW1N4hGPVnbeWqH7NhAq/R2uCiKA28hz22L6Qiyk/QG9fAQudEJHll
	 xoT853egqorC8pmtINZ1pC291TXclCLQlqpvkg5l8F+aaMRAjrBVFzwc0VmxVc+9kL
	 U7DsYiG6c0lfw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Mar 2025 14:44:48 +0100
X-ME-IP: 124.33.176.97
Message-ID: <8bd91034-cc4f-435d-86ef-cc76fa0a3612@wanadoo.fr>
Date: Mon, 24 Mar 2025 22:44:39 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: rockchip_canfd: fix broken quirks checks
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250324114416.10160-1-o451686892@gmail.com>
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
In-Reply-To: <20250324114416.10160-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Weizhao,

Thanks for the patch.

On 24/03/2025 at 20:44, Weizhao Ouyang wrote:
> First get the devtype_data then check quirks.
> 
> Fixes: bbdffb341498 ("can: rockchip_canfd: add quirk for broken CAN-FD support")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


