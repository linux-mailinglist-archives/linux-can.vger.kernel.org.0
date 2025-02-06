Return-Path: <linux-can+bounces-2738-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA7A2A69F
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 12:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690BC168973
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712C2288D3;
	Thu,  6 Feb 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HlF2JkqG"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364422757F;
	Thu,  6 Feb 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839424; cv=none; b=o1iqeAK3bgbMIYIUzbadP4a5OZox/5uyiYibUDkTBTCUERriZaC2wDGeYhByKLg5PZGMmAUjhkqJFzg0CMH8kCsEEKGCepP/ETIlvC2Qwx4/uD+NlqgArRHewyJitlveZUckFtLilgCaJWk+8hQFXl30Sh8+fXV1qb0eTFKjpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839424; c=relaxed/simple;
	bh=mZF4WJ4wshkC4Qp7P9+LXM8kZ9ppCOLNmAFpDQZp3G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL2scXBEcUP8p+9ZIJ6+kQ6W1tEPoD27EXZjqpl4r/T3+otdwfRQVLdKr/o0jUvnXv+R7YVrL08yP9QK9dzlXJasr1C4bqI5rWTHmy30G0Z+erv4Rj/UzAG9aKnwgK0jMYYhLyjxiKzLMb+juWTBrbLkak9NjZ350LFFzlxq6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HlF2JkqG; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id fzYjtDgo1Ft3IfzYutp3tQ; Thu, 06 Feb 2025 11:56:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738839414;
	bh=wTaI7uWxfJ722CWHtIPOl9T+pRsm8ifKzI8h9O+PI5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HlF2JkqG5ukjEpbIBd4tr6yYQuDznjpL7a043gTv4H77qYLXx59j5W8NHZGzXGRyl
	 GQ7q6N85iRiKLecZFckTpwlOCr2sakj3sZrltqKpvXf0kS02r7GWO+SjCkF6+LSLdM
	 iq2XQ8/NsB9Gdul/7toFTk/XmIDsQNbIMOwzqohUOka8QI3SMtW+tIirxARB3wL5HN
	 L3c0aRE+6OxptM+EIdcXj0qCVNGs1vFCqMi6ZeRRhwRS7xEFNmGoru7PhrQ5lf5Ak2
	 X4lSj1n3zzZZ+MxAeJXyJ1bNsXexiQpE+SaPL17Z98ulsYrqtu08eGiR+aLyB2f48x
	 KpRr3KtrNgjpQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Feb 2025 11:56:54 +0100
X-ME-IP: 124.33.176.97
Message-ID: <e0aeefc5-bf01-42ab-91e4-e727d560c983@wanadoo.fr>
Date: Thu, 6 Feb 2025 19:56:36 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Remove repeated word in docs
To: Charles Han <hanchunchao@inspur.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-doc@vger.kernel.org, mkl@pengutronix.de,
 manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, cem@kernel.org,
 djwong@kernel.org, corbet@lwn.net
References: <20250206091530.4826-1-hanchunchao@inspur.com>
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
In-Reply-To: <20250206091530.4826-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/02/2025 at 18:15, Charles Han wrote:
> Remove the repeated word "to" docs.
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml        | 2 +-
>  Documentation/filesystems/xfs/xfs-online-fsck-design.rst        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> index 2a98b26630cb..c155c9c6db39 100644
> --- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> @@ -40,7 +40,7 @@ properties:
>  
>    microchip,rx-int-gpios:
>      description:
> -      GPIO phandle of GPIO connected to to INT1 pin of the MCP251XFD, which
> +      GPIO phandle of GPIO connected to INT1 pin of the MCP251XFD, which
>        signals a pending RX interrupt.
>      maxItems: 1
>  
> diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> index 12aa63840830..994f9e5638ee 100644
> --- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> @@ -4521,7 +4521,7 @@ Both online and offline repair can use this strategy.
>  | For this second effort, the ondisk parent pointer format as originally   |
>  | proposed was ``(parent_inum, parent_gen, dirent_pos) → (dirent_name)``.  |
>  | The format was changed during development to eliminate the requirement   |
> -| of repair tools needing to to ensure that the ``dirent_pos`` field       |
> +| of repair tools needing to ensure that the ``dirent_pos`` field       |

This breaks the indentation of the pipe on the right.

>  | always matched when reconstructing a directory.                          |
>  |                                                                          |
>  | There were a few other ways to have solved that problem:                 |


Yours sincerely,
Vincent Mailhol


