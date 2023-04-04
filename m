Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66396D61B8
	for <lists+linux-can@lfdr.de>; Tue,  4 Apr 2023 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjDDM4q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Apr 2023 08:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjDDM4q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Apr 2023 08:56:46 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FAD212A
        for <linux-can@vger.kernel.org>; Tue,  4 Apr 2023 05:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680613003; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J1/iRbpKaY6ZLg+0uUMrNb6LRnDNnCuXgzTNMBkJzNr/Tn4Zj7c2hfviz33H//YSn9
    bK8Xsgl2ujX604JXMQXUHllEL8jO7Zfzt4psovLC5K8xNwhp/Hq5oBMYpQDBwEze/ImG
    YLK4sQRwOVIPk10hnUIXNc5T+fHrKWb2KtgiyO3uqCwpBhQ5kWKb9+xLAleJmAXofMo9
    9j4wAvRYnO9ceI/Pdm2+7MTT/9p281Dtqb4utiMoKfwN81DzI8r+SV4Z87Xur3Nma73K
    Ifrajw+6MZbL6Rh+zOjc0D+ptJEZrPnBWGD3R1VMV8S0q8fP3xvxoB7Tq4cwRDDCxnvO
    5jnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680613003;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=85IoRsmUiT8Cnc7F8ohJG5tP57sjb3vnDzC0+0cYsPc=;
    b=VcwPTlQcZhJP6ji1gkewPaZ8RuLGa79JE10VRNd9Le/VcNsoucUNViI/fL/tzkWkOJ
    SRtUeebIsFLRqLMcHUwacZdncQk0pH8+Ws8LjC6yI9UNNXwVk9CYJEc1X/Mq0lkj3uNe
    ZB5PpdO5qspjfr5qQVfs9NVEMdZZUzHi/4DwvasMwLJ2vjwjhmtHZV6ylQrANk07dC+7
    ZXKMQgMok0tP08C+Y+6/G6oRlCJJRK2vNmr8oFpA3bbQ8pjnPpHRQ9f1zd0Sl2VEn/2z
    ITfTaanpFLK+h5WsBKCeNiIVelVmm5pWVW47+qmswJYF8BV1OjmPXM9dgBYmS743yUa7
    wTIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680613003;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=85IoRsmUiT8Cnc7F8ohJG5tP57sjb3vnDzC0+0cYsPc=;
    b=b+NsXwnmbJe7VwyczcmrIlx2vBrKU6kESAfZ8Xr6crDaCsljtpxQ+qlIPxgApxVpWj
    e7CuTKZShALdk+G+k4JxWN5hDmjLYQPsP1/Yi5a3+WmCRkdu00r9JMVEBoGnCohNcg6I
    sUTr/0Svs/sB120HhWiIZ3M+5eHzvIRRkDVQwRhzyW180I+U49whM0u4AoC/ob05DKvB
    rB6zArXPyMSosLhvcCqt/DVpegvGhQv35QXk/XnlfFXtkuNhKLPlUFoWSrfERESfjaaG
    hUYawLtWmzRltlhcngOljBl0UBJVmQDQitNahYmVZOdG7zEOf3bXygS3vtyvCCtaNme3
    gKww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680613003;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=85IoRsmUiT8Cnc7F8ohJG5tP57sjb3vnDzC0+0cYsPc=;
    b=lG2OKUggZZuZ642wSrpAnbEi50NR1mvISWhB2kbXt8o1hUddPqBxxChdFc3VXIL4xp
    5wfEZMuJ6V0Ef3oWdvAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x06214z34Cuh2so
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 Apr 2023 14:56:43 +0200 (CEST)
Message-ID: <3ebe8125-d950-65f2-8a5c-24156e0ae10a@hartkopp.net>
Date:   Tue, 4 Apr 2023 14:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] can: isotp: use sock_recv_cmsgs() to get SOCK_RXQ_OVFL
 infos
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <20230330170248.62342-1-socketcan@hartkopp.net>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230330170248.62342-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

can you please apply this one too?
I was using it to detect the poll receive buffer error.

Thanks,
Oliver

On 30.03.23 19:02, Oliver Hartkopp wrote:
> isotp.c was still using sock_recv_timestamp() which does not provide
> control messages to detect dropped PDUs in the receive path.
> 
> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/isotp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9bc344851704..47c2ebad10ed 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1118,11 +1118,11 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>   
>   	ret = memcpy_to_msg(msg, skb->data, size);
>   	if (ret < 0)
>   		goto out_err;
>   
> -	sock_recv_timestamp(msg, sk, skb);
> +	sock_recv_cmsgs(msg, sk, skb);
>   
>   	if (msg->msg_name) {
>   		__sockaddr_check_size(ISOTP_MIN_NAMELEN);
>   		msg->msg_namelen = ISOTP_MIN_NAMELEN;
>   		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
