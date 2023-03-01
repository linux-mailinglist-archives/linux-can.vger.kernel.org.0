Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3A6A75A3
	for <lists+linux-can@lfdr.de>; Wed,  1 Mar 2023 21:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCAUzp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 1 Mar 2023 15:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAUzo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 1 Mar 2023 15:55:44 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012ED4347B
        for <linux-can@vger.kernel.org>; Wed,  1 Mar 2023 12:55:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677704140; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WqgAK5X10GgMq44Rm+T2gxnF6fMnhsSu85pvbnOnJWUdMxQFz1/wkh1jGXXcstFcXm
    dEVtlhPQotPpfKdK9IjP8stGpOeZrDgJ/Vw06oW0hxyAS+mDzYtu7JtwXpdayRSPE5j1
    AxCIRCUgY1Nr7RcQnujLe8FM8/nYBUTNV5uhFS+paFOILAma2uttLO3+wsokql35euk2
    F0aAkiiPZaQDiQ9A4LarG3mVrs6Z9R+qLZzDDENAMKb7WaaAvh688dPQNRU6C0Zl+dIS
    8s/lJbEJPfTAdNxPgfv6KG/T1c3CaPoWirh6YlgpOcqPSypKQLhtuHHbVSmyrZhEezUA
    8aVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1677704140;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Em6TT0P5DJ20Di8tbVT1rAN71gvVP5cjemkv5NiKziw=;
    b=PyN+mCPC3MKd97MlDybJaJFStqjiXuWf1GiPXOh1isXB691U5Xi+gxu4AvB/6ZqFBz
    fHtf+Rq0R9IjjUEbZPKJxgR6IhVAEyVhk9FyBqr9Da7v7a/nxRBojg2tQOU0ol61Qagw
    IfqkZapT3KtO6D914WCy3wk1IY9f01uYls+jsHLaVmpwwl7wxHR9++6PQYJbxzfElgol
    uaXO7WUVWjc/dY0PzZqCADTHUmml5sJor2LPLXmmiFhrc9ApxJSXS5YiqxsPw2HQRxTJ
    qIFOY70loCe7AyYXorfPwKftOUk8gt9UHTr4U166xIeG/Ey9qEliRu/Yf1eDRMy+Dbwh
    EA6w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1677704140;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Em6TT0P5DJ20Di8tbVT1rAN71gvVP5cjemkv5NiKziw=;
    b=BE6BXzt4zN432Q00vKdzlJipnc4At2WMuPIGMCqyUxHb3TFVDMuZR6pvA36HUz+NtB
    TduDaNxjLZm8EhPuYFssY0f3HKikgfkgLQtZzS60fjdq+ThFPSL3iWyJ1QXU69F+Si+X
    UX/oWoE8vrDafZ6tV5Wlm4oZTppSM/zDDdpwIrVEp2d8vjl+QdM2rd180HB5/B+OKGLr
    1mGpi0vCDSgCohk7snp/AIV1V6/JKkdMHz2wqlLSHxOtI0mUVA3RmoajIFCcCu7B7F0I
    H6cCWAUpZSJAAvBBUWuQg+5awD4lEtWx166gut92K2Eb+3AG0kFzZ6gccoy95ygChi5R
    EVxg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id c675b3z21Kte4eH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 1 Mar 2023 21:55:40 +0100 (CET)
Message-ID: <3020cefb-0dc5-bed6-a31c-39bbc7fec3f4@hartkopp.net>
Date:   Wed, 1 Mar 2023 21:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: please re-send [RFC PATCH] can: isotp: fix poll() to not report
 false positive EPOLLOUT events
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Michal Sojka <michal.sojka@cvut.cz>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
 <878rghtt0p.fsf@steelpick.2x.cz>
 <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
Content-Language: en-US
In-Reply-To: <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I added the sockopt CAN_ISOTP_WAIT_TX_DONE in isotp-poll-test.c which 
fixes the problem:

(..)

struct sockaddr_can addr;
static struct can_isotp_options opts = { .flags = CAN_ISOTP_WAIT_TX_DONE};

(..)

sock = CHECK(socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP));

CHECK(setsockopt(sock, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opts, sizeof(opts)));

(..)

The sockopt uses a wait queue and returns from the write() syscall when 
tx.state becomes ISOTP_IDLE.

Using the isotp socket without CAN_ISOTP_WAIT_TX_DONE turned out to be 
not such good idea. But this results from the original API which had 
some kind of "fire-and-forget" mode.

Today the tx.state is set back to ISOTP_IDLE in isotp_rcv_echo() - and 
with this short 9 byte PDU the interaction with the receiving entity is 
really fast on vcan's. Maybe faster than the the write syscall returns.

I don't know what happens to the poll notification then.

Best regards,
Oliver


On 01.03.23 19:59, Oliver Hartkopp wrote:
> Hi Michal,
> 
> just copied the text to answer your patch ...
> 
> On 28.02.23 21:49, Michal Sojka wrote:
> 
>  > When using select/poll/epoll() with a non-blocking ISOTP socket to
>  > wait for when non-blocking write is possible, false EPOLLOUT event is
>  > sometimes returned. This can happen at least after sending a message
>  > which must be split to multiple CAN frames.
>  >
>  > The reason is that isotp_sendmsg() returns -EAGAIN when tx.state is
>  > not equal to ISOTP_IDLE and this behavior is not reflected in
>  > datagram_poll(), which is used in isotp_ops.
>  >
>  > This is fixed by introducing ISOTP-specific poll function, which
>  > suppresses the EPOLLOUT events in that case.
> 
> 
> Good improvement!
> 
>  > Below is a program that can trigger the problem on a vcan interface.
>  > When running the program as:
>  >
>  >      ./isotp-poll-test -s 123 -d 321 -o
>  >
>  > it starts sending ISOTP messages that include increasing ASCII
>  > numbers. poll() is used to wait before next transmission.
>  >
>  > With current mainline Linux, once the message length is greater than 7
>  > bytes, write() returns -EAGAIN and the program terminates. This should
>  > not happen, because the previous poll() reported that the write()
>  > would not block.
>  >
>  > After applying this patch, the above command doesn't fail - if one
>  > runs some ISOTP reader such as:
>  >
>  >      isotprecv -l -s 321 -d 123 vcan0
>  >
> 
> Yes, I can confirm that the above setup works - but not reliable:
> 
>  > This test program can also show another problem. When running:
>  >
>  >      ./isotp-poll-test -s 321 -d 123 -i -a
>  >
>  > and then in another terminal:
>  >
>  >      ./isotp-poll-test -s 123 -d 321 -o
>  >
>  > The first program receives the messages and uses the counter values to
>  > check for lost messages. After a random number of iterations a lost
>  > message is always detected. I believe that ISOTP should be reliable
>  > protocol, at least on vcan, shouldn't it?
> 
> The problem seems to occur with the new introduced POLL feature.
> 
> When using
> 
>      ./isotp-poll-test -s 123 -d 321 -o
> 
> together with
> 
>      isotprecv -l -s 321 -d 123 vcan0
> 
> the transmission of isotp PDUs stops at some point
> #8179 #6204 #1787 #373 #69321 etc
> 
> I can not see problems or drops when using
> 
> ./isotpsend vcan0 -s 123 -d 321 -D 9 -li
> 
> as data producer where I added a counter:
> 
> diff --git a/isotpsend.c b/isotpsend.c
> index deac601..815c254 100644
> --- a/isotpsend.c
> +++ b/isotpsend.c
> @@ -96,10 +96,11 @@ int main(int argc, char **argv)
>       useconds_t usecs = 0; /* wait before sending the PDU */
>       __u32 force_tx_stmin = 0;
>       unsigned char buf[BUFSIZE];
>       int buflen = 0;
>       int datalen = 0;
> +    u_int32_t datainc = 0;
>       int retval = 0;
> 
>       addr.can_addr.tp.tx_id = addr.can_addr.tp.rx_id = NO_CAN_ID;
> 
>       while ((opt = getopt(argc, argv, "s:d:x:p:P:t:f:D:l:g:bSCL:?")) != 
> -1) {
> @@ -295,10 +296,13 @@ int main(int argc, char **argv)
> 
>   loop:
>       if (usecs)
>              usleep(usecs);
> 
> +    memcpy(&buf[datalen - 4], &datainc, 4);
> +    datainc++;
> +
>       retval = write(s, buf, buflen);
>       if (retval < 0) {
>              perror("write");
>              return retval;
>       }
> 
> 
> Maybe the 'poll' patch needs to check for something else. I will take a 
> look at it.
> 
> Many thanks,
> Oliver
> 
