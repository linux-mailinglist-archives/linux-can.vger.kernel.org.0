Return-Path: <linux-can+bounces-4116-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED1B1170F
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 05:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07301CE019F
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 03:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E5230BF8;
	Fri, 25 Jul 2025 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="S28EAh+j"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6D86329;
	Fri, 25 Jul 2025 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414071; cv=none; b=o9x083KM++GEwJ1goHGGyYvJnlNhuDIbQ2D6vHBWjXLO+RfReEW/3JxOSKZ62Hs/VgeMVfnUcHbQo5mdG4bWLexFtV0QM9/q7cZcH7bwi1BpwXTbyVwYadeM62D+MmDy6g9muOlh0pZ9BxQSuYPbhuy06GvY585JmvRyrGH0BHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414071; c=relaxed/simple;
	bh=joFoIEp2MhfeYMz/5yiVj7fDitnwO5IAFIVFVl67TD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6WIUX/w6OGsytx0yLTUxEFBBzAdYtr1NVBqF8Os1dDP2+bntuQaAfoPVkBZh0J8KkBhtGKvuxBk0nbfE7K3g1gRPXJ+u+KivJDpr/Z14a49kP7bFxxl7YqUtm7tRmJ5DBi0GjEkxD0fLTFQex+Dzz+KzrUMJ4hXrQY+wAgAC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=S28EAh+j; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id f95tu6CmcnKC4f95vuJEKJ; Fri, 25 Jul 2025 05:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753414061;
	bh=8c5lhhnWTjIcoXe0mvaMVVa55uWJjVb0zrg3deiTwwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=S28EAh+j9enxdBFUFF/c/Zgy+YeajJX1CQM5JAUL9FaCukcv4qKnD0iV+9+B/ZOCx
	 vqBxYfynU1YZDcdb8hZi3M5APc4BQpDcP0iV4X734Xq5zK/PRCaWZc38NJERlBR2i4
	 fmfBCo2rWJ98/HaI+ovBNNajkMnVLxKGhqmpOyWR0F4kTKSlGYJXUsWaAPOU4BTl9L
	 OWl/TWxe35Cuu9jLusWR1tidgZVDuDkNb2dMvPaKVAlF07PCt4ZsmIKVSNa7tslDLo
	 QLvvDx/7a2zmgI32fDiXs6rYGdLiLhQkvoFdqTFvzwBtSj/moolhm4guGlwKs2I4dO
	 c2z04e0DFScSA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Jul 2025 05:27:41 +0200
X-ME-IP: 124.33.176.97
Message-ID: <03a6d0c8-1dac-47dd-b5eb-b22ff108afe3@wanadoo.fr>
Date: Fri, 25 Jul 2025 12:27:36 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] Documentation: devlink: add devlink
 documentation for the kvaser_usb driver
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
References: <20250724092505.8-1-extja@kvaser.com>
 <20250724092505.8-12-extja@kvaser.com>
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
In-Reply-To: <20250724092505.8-12-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 at 18:25, Jimmy Assarsson wrote:
> List the version information reported by the kvaser_usb driver
> through devlink.
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
> Changes in v2:
>   - New in v2. Suggested by Vincent Mailhol [1]
> 
> [1] https://lore.kernel.org/linux-can/5cdca1d7-c875-40ee-b44d-51a161f42761@wanadoo.fr/T/#mb9ede2edcf5f7adcb76bc6331f5f27bafb79294f
> ---
>  Documentation/networking/devlink/index.rst    |  1 +
>  .../networking/devlink/kvaser_usb.rst         | 33 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/networking/devlink/kvaser_usb.rst
> 
> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
> index 8319f43b5933..26c28d0e8905 100644
> --- a/Documentation/networking/devlink/index.rst
> +++ b/Documentation/networking/devlink/index.rst
> @@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
>     ionic
>     ice
>     ixgbe
> +   kvaser_usb

This will create a tiny merge conflict when applying both the kvaser_pciefd and
this series.

I think it would be smoother if you rebase either of these on top of the other.
Just add a note in the cover letter of which one should be merged first.


Yours sincerely,
Vincent Mailhol


