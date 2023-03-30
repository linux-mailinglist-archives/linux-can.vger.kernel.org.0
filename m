Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9064B6D0CD0
	for <lists+linux-can@lfdr.de>; Thu, 30 Mar 2023 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjC3Ray (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 30 Mar 2023 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjC3Ray (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Mar 2023 13:30:54 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C10CDF9
        for <linux-can@vger.kernel.org>; Thu, 30 Mar 2023 10:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680197451; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HAf9qOECxK+dlZ9K6rWyOMMwTeYeMOLz9rWVSyjrZ2s3v4SIFiAzuO+WjSkQ8jDeXl
    soFKbjz4zM0AecJW3hcHQlGuDkMy8iP08oUs1lJ/ggyXRBGBk6O8QEGWKCnjr6x7jdm7
    AK5DqrVH+/hitKAI3pskzZuvhvLi0w1zzzavfNIjKnUbZ0jM55lGk+vuD4K0hdBRnpb/
    WplhuZNt/gk49pqj/5DzbREzd4FPePXIpH3TAdb0ucjHCsrTF01XXTyK24wyxcV4+mvV
    3t5AdoQAWwXFHKY9XSRw6kUkXZTHdrA+fnhQ/uOgv2z6QWEl7brNa1HY5E9zOr7QEtDh
    QYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680197451;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tVh9/PyWo+W6BXG/3pFwNo9baLHk6ShdR/ibFEpXOWY=;
    b=soOKXO0wf1R6U1pzPDG1+0QFFBmGZc1RN/zlSpNt0qUuBf3X8KSEEFSwo5Li2+O3T5
    atQRprfWB6v+wI8WidunpKVgWu7ynMq19NqnaJy2dVQZvgMQuNpS8GZWHPABVhM9B5tj
    w3xov0jPKXXpfvdraH4V0DkdpPV2/pQtDrq7r9mpFHItBwN8VwVi3v0okOU6hZ2GVkbj
    I3FXa5GYzqCm8JXYKD5S0GCsy/9bbhOiloBhB+HoyK56263IHL6+2yoOJsq2WmHyj2AW
    7EioZdTf/sUIiKDRb65E0HKWOorqPBrW+7oAIstXaLbEEFLs98oWSIqYHKUXiyuvZeL4
    aUGw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680197451;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tVh9/PyWo+W6BXG/3pFwNo9baLHk6ShdR/ibFEpXOWY=;
    b=DNJDJzQ2GpnmWsxGAjfNKwaEY56akGygjJWbHURqCDz2Zx7HyQq2RWROgjVG/llppz
    Hg4Lk6NyKk6y4MHH0uS3jzZSICWirI/7QVJXrJspFaQusRciaIvtTvzqRTT92BJJ7FAa
    SkRJMVghYxVaYF45Wx3nkWxqHvbrIB6uO+KuOvAApiAIsb3JT0i9vL5+DibznD7FBXRW
    oOCd7Tjv3BpcQSF4IxbejpdCtZPhJJlOGKIGhG66M3ruZs8ltDVVM1jkopsUZ7pC7Fvz
    THOt7tWgoUukE64MVa9/JidcpJB9nLSmlTn2vS3WNXj7PCamZw6GlE6h58b5I7J+KBVg
    /oRg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2UHUogv8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 30 Mar 2023 19:30:50 +0200 (CEST)
Message-ID: <4d48e780-5655-f251-05ee-623cbce0d20e@hartkopp.net>
Date:   Thu, 30 Mar 2023 19:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v2] can: isotp: fix poll() to not report false
 EPOLLOUT events
Content-Language: en-US
To:     Michal Sojka <michal.sojka@cvut.cz>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <87zg8vjyqg.fsf@steelpick.2x.cz>
 <20230302092812.320643-1-michal.sojka@cvut.cz>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230302092812.320643-1-michal.sojka@cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 02.03.23 10:28, Michal Sojka wrote:
> When using select/poll/epoll() with a non-blocking ISOTP socket to
> wait for when non-blocking write is possible, false EPOLLOUT event is
> sometimes returned. This can happen at least after sending a message
> which must be split to multiple CAN frames.
> 
> The reason is that isotp_sendmsg() returns -EAGAIN when tx.state is
> not equal to ISOTP_IDLE and this behavior is not reflected in
> datagram_poll(), which is used in isotp_ops.
> 
> This is fixed by introducing ISOTP-specific poll function, which
> suppresses the EPOLLOUT events in that case.
> 
> This can be tested with a program available at
> https://github.com/wentasah/isotp-poll-test/blob/fd095b2242c49dc5d3e36faf5ac9f4f47fd002c7/isotp-poll-test.c
> which can trigger the problem on a vcan interface. When running the
> program as:
> 
>      ./isotp-poll-test -s 123 -d 321 -o
> 
> it starts sending ISOTP messages that include increasing ASCII
> numbers. poll() is used to wait before the next transmission.
> 
> With current mainline Linux, once the message length is greater than 7
> bytes, write() returns -EAGAIN and the program terminates. This should
> not happen, because the previous poll() reported that the write()
> would not block.
> 
> After applying this patch, the above command doesn't fail - if one
> runs some ISOTP reader such as:
> 
>      isotprecv -l -s 321 -d 123 vcan0
> 
> This test program can also show another problem. When running:
> 
>      ./isotp-poll-test -s 321 -d 123 -i -a
> 
> and then in another terminal:
> 
>      ./isotp-poll-test -s 123 -d 321 -o
> 
> The first program receives the messages and uses the counter values to
> check for lost messages. After a random number of iterations a lost
> message is always detected. I believe that ISOTP should be reliable
> protocol, at least on vcan, shouldn't it?
> 
> Anyway, this patch doesn't try to address this problem.
> 
> Signed-off-by: Michal Sojka <michal.sojka@cvut.cz>
> Reported-by: Jakub Jira <jirajak2@fel.cvut.cz>

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

@Michal: Would you like to rework the commit message or is it just ok to 
cut the message after

"This can be tested with a program available at ..."

?

Best regards,
Oliver

> ---
> Changelog:
> 
> v2: Added waiting for isotp-specific wait queue: poll_wait(file, &so->wait, wait).
> ---
>   net/can/isotp.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9bc344851704..ec163e36ac53 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1608,6 +1608,21 @@ static int isotp_init(struct sock *sk)
>   	return 0;
>   }
>   
> +static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *wait)
> +{
> +	struct sock *sk = sock->sk;
> +	struct isotp_sock *so = isotp_sk(sk);
> +
> +	__poll_t mask = datagram_poll(file, sock, wait);
> +	poll_wait(file, &so->wait, wait);
> +
> +	/* Check for false positives due to TX state */
> +	if ((mask & EPOLLWRNORM) && (so->tx.state != ISOTP_IDLE))
> +		mask &= ~(EPOLLOUT | EPOLLWRNORM);
> +
> +	return mask;
> +}
> +
>   static int isotp_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
>   				  unsigned long arg)
>   {
> @@ -1623,7 +1638,7 @@ static const struct proto_ops isotp_ops = {
>   	.socketpair = sock_no_socketpair,
>   	.accept = sock_no_accept,
>   	.getname = isotp_getname,
> -	.poll = datagram_poll,
> +	.poll = isotp_poll,
>   	.ioctl = isotp_sock_no_ioctlcmd,
>   	.gettstamp = sock_gettstamp,
>   	.listen = sock_no_listen,
