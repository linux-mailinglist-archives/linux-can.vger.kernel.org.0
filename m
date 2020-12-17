Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCE2DDB29
	for <lists+linux-can@lfdr.de>; Thu, 17 Dec 2020 23:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgLQWDJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Dec 2020 17:03:09 -0500
Received: from smtp.cubyte.cloud ([62.113.199.100]:4434 "EHLO
        smtp.cubyte.cloud" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732021AbgLQWDJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Dec 2020 17:03:09 -0500
Received: from [192.168.1.10] (i59f4b54f.versanet.de [89.244.181.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.cubyte.cloud (Postfix) with ESMTPSA id 9627140623;
        Thu, 17 Dec 2020 22:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schich.tel; s=mail;
        t=1608242539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUXDa6YRPW94a44D6R39Y4RO8LIilQvaZJZh7tumHCo=;
        b=mzE2LNXXLZKkyJQiEnGTQucYkWxSTM4xYmRq1XLz5MINxtnbWq0TsvYqEweJeaFRj7oIOR
        wvSt4/vSmf0A98FVS2hBA7ggeAyx6dZRkf33MxhqNtp5fw/6Z1Lz4LLKvzFzQw5v6GqjGx
        68zhs1rXH1YsR1hOChqAL2vu4jfgrIPTuNgedCzd5oENqw27/aPd2aGey+coJXSvTDopY+
        50agdNOaWob4Sms9IBauzJHHnuUX5GvnUBSdWGnw25ZvXcmKSVfUqylgK0hnrvtm23b9H7
        Gb/L3gsQNN0VoQqOSnoyx/qc8QIPp7alt9MTW1Ctrs8el9SubwZuzcjLtWf4tA==
Message-ID: <09c502034255306d9aa49a34451679f16ead02e7.camel@schich.tel>
Subject: Re: [RFC PATCH can-next] can: raw: return -ERANGE when filterset
 does not fit into user space buffer
From:   Phillip Schichtel <phillip@schich.tel>
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Date:   Thu, 17 Dec 2020 23:02:18 +0100
In-Reply-To: <20201216174928.21663-1-socketcan@hartkopp.net>
References: <20201216174928.21663-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 2020-12-16 at 18:49 +0100, Oliver Hartkopp wrote:
> Multiple filters (struct can_filter) can be set with the setsockopt()
> function, which was originally intended as a write-only operation.
> 
> As getsockopt() also provides a CAN_RAW_FILTER option to read back
> the
> given filters, the caller has to provide an appropriate user space
> buffer.
> In the case this buffer is too small the getsockopt() silently
> truncates
> the filter information and gives no information about the needed
> space.
> This is safe but not convenient for the programmer.
> 
> In net/core/sock.c the SO_PEERGROUPS sockopt had a similar
> requirement
> and solved it by returning -ERANGE in the case that the provided data
> does not fit into the given user space buffer and fills the required
> size
> into optlen, so that the caller can retry with a matching buffer
> length.
> 
> This patch adopts this approach for CAN_RAW_FILTER getsockopt().
> 
> Reported-by: Phillip Schichtel <phillip@schich.tel>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tested-By: Phillip Schichtel <phillip@schich.tel>

Successfully tested this in my Java bindings.

~ Phillip

> ---
>  net/can/raw.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 6ec8aa1d0da4..37b47a39a3ed 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -663,14 +663,22 @@ static int raw_getsockopt(struct socket *sock,
> int level, int optname,
>         case CAN_RAW_FILTER:
>                 lock_sock(sk);
>                 if (ro->count > 0) {
>                         int fsize = ro->count * sizeof(struct
> can_filter);
>  
> -                       if (len > fsize)
> -                               len = fsize;
> -                       if (copy_to_user(optval, ro->filter, len))
> -                               err = -EFAULT;
> +                       /* user space buffer to small for filter
> list? */
> +                       if (len < fsize) {
> +                               /* return -ERANGE and needed space in
> optlen */
> +                               err = -ERANGE;
> +                               if (put_user(fsize, optlen))
> +                                       err = -EFAULT;
> +                       } else {
> +                               if (len > fsize)
> +                                       len = fsize;
> +                               if (copy_to_user(optval, ro->filter,
> len))
> +                                       err = -EFAULT;
> +                       }
>                 } else {
>                         len = 0;
>                 }
>                 release_sock(sk);
>  


