Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20645E030
	for <lists+linux-can@lfdr.de>; Thu, 25 Nov 2021 19:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbhKYSH3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Nov 2021 13:07:29 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:20976 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349122AbhKYSF3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Nov 2021 13:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637863324;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RCyp6dreG24KpxCzJIjuC41qsGF3YLwk0/mkukUoCLw=;
    b=V9QCHOJcfuAV9NroaCT56NekDlmkFm9aliPQu+gMETzZL98RVYVzJtD/moyPnuxats
    U+w4PhoizbrjanPyRYNFX/fUPi7nfGLYz0fyfSVgYBXCYvF7nYYhMki4hEcH6bCPyBB8
    L54HwgbMh0hcg2BnXVPmnXmEID8s3g1LN7Lelg8kBhV7V5wjNsbry9JKzurcQcH/V+bz
    XRjhL8Nn/3dC283FzcOekXfyF4XBkf7ussEnwgKcRoNROMGnXFx+wbcR3xaQiVyZnYWJ
    FM8isycuX2t9sHGGR3mRiwBK0HouY0sKZyF1fDvSMwGzixnERWTvwF2L/BTJIItrpkMC
    Qxaw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.34.10 AUTH)
    with ESMTPSA id c09e88xAPI244L8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 25 Nov 2021 19:02:04 +0100 (CET)
Subject: Re: [PATCH v0] can: raw: supplement the check to prevent the NPD
To:     Lin Ma <linma@zju.edu.cn>, linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org
References: <20211125084655.16974-1-linma@zju.edu.cn>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <0801ace2-5885-d579-aa8f-177c0cc5c2da@hartkopp.net>
Date:   Thu, 25 Nov 2021 19:01:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211125084655.16974-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Lin Ma,

thanks for looking into this!

On 25.11.21 09:46, Lin Ma wrote:
> The CAN_RAW_FILTER command allows the user to pass optlen as value 0. It
> is expected to clear out the filer
> 
> static int raw_setsockopt(...) {
>    struct can_filter *filter = NULL;
>    ...
>    // count = 0 if optlen = 0
>    count = optlen / sizeof(struct can_filter);
>    ...
>    ro->filter = filter;
>    ro->count  = count;
>    ...
> }
> 
> However, if this sock is bound to a device, bad thing happens as the
> current check is failed to prevent the NULL Pointer Dereference.
> 
> static int raw_setsockopt(...) {
>    ...
>    if (ro->bound) {
>      /* (try to) register the new filters */
>      if (count == 1)
>        err = raw_enable_filters(sock_net(sk), dev, sk,
>                                 &sfilter, 1);
>      else
>        // count = 0 can enter here while filter = NULL
>        // which is unexpected
>        err = raw_enable_filters(sock_net(sk), dev, sk,
>                                 filter, count);
>    ...
> }
> 
> This patch supplements the comparison with additional check.
> 
> Fixes: commit c18ce101f2e4 ("[CAN]: Add raw protocol")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>   net/can/raw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 7105fa4824e4..590df2da081c 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -564,7 +564,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   			if (count == 1)
>   				err = raw_enable_filters(sock_net(sk), dev, sk,
>   							 &sfilter, 1);
> -			else
> +			else if (count > 1)
>   				err = raw_enable_filters(sock_net(sk), dev, sk,
>   							 filter, count);
>   			if (err) {
> 

AFAICS this additional check is not needed.

Please look into raw_enable_filters():

static int raw_enable_filters(struct net *net, struct net_device *dev,
                               struct sock *sk, struct can_filter *filter,
                               int count)
{
         int err = 0;
         int i;

         for (i = 0; i < count; i++) {
                     ^^^^^^^^^

This check ( 0 < 0 ) is never true in your described use-case. Therefore 
we do not enter the for-loop and the pointer to the filter is never 
dereferenced.

Or do I overlook something?

E.g. the can-utils tool 'cansend' is setting the filter to NULL:

https://github.com/linux-can/can-utils/blob/master/cansend.c#L157

But it does not crash - just double checked today ;-)

Best regards,
Oliver

                 err = can_rx_register(net, dev, filter[i].can_id,
                                       filter[i].can_mask,
                                       raw_rcv, sk, "raw", sk);
                 if (err) {
                         /* clean up successfully registered filters */
                         while (--i >= 0)
                                 can_rx_unregister(net, dev, 
filter[i].can_id,
                                                   filter[i].can_mask,
                                                   raw_rcv, sk);
                         break;
                 }
         }

         return err;
}

