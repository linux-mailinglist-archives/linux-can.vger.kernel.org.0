Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116DB375982
	for <lists+linux-can@lfdr.de>; Thu,  6 May 2021 19:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhEFRhM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 May 2021 13:37:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:25734 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbhEFRhM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 May 2021 13:37:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620322567; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cApSqb15r/DNxi14MDn2WDed07HkJrq+36allECpddL8NLblM88aUBKEDJdOGo6nME
    byujEBosXjaR08LusfA0i1KFLbr+oTUG139b1+Cbo3Sg8nArmJzzfwUAm0/rZ1zlUD6V
    EVV2lX4A5gAKrmFJCYJ5R7K4NywOR/F1jxxltzgTI3MHsyQKfCct1zrlse12ULEdRjDJ
    BzCfYGE2fQ0LS9xZGfNeWcS7n2gvMUT+HFeuhg9SZG7NUPRRs2atAqY6taZ2zdpnrMgY
    42f6ZnMKhLgVGXqvfNatit5Z2/wtG0Wyv/EU+aREOBVBAAAtxb3brWCJpZJEbDAk7/g3
    j/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620322567;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=s8CpxpaU16L9DB3+oeYLUekE1BwAE0zRd20pTsdguhE=;
    b=nvLclHOw+w2aM4zf49HVtalZkXZ2uPBMpzRDdhBsS3i9K10MIG5/RQdJZBzuRrg1GM
    aC2UO1po4pJRdcl9/WU78BxPtB5nxBJ220kpTvq8SqObi6ayAij2T+ayr/SrH8+LKLbg
    q/uQMyAlPUNbnuyFO+4bUS/zJdj3jnXkBhtjIljI2RPNkYr80IDDfNq9k8W6e4ksH9un
    IBOD0CDhkyaUzQ03rbhxLBgpQk7uPdG7oja5mdHTu4ebUikUFzPKU/ufuFTnlNurEW0N
    sxMQIOMqJ65xUkZ/rZsB+wd2gM3aDWcXy+/+pxXrzaxQFGIsXn+I0cEAUEZn3cywRoo8
    5WBw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620322567;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=s8CpxpaU16L9DB3+oeYLUekE1BwAE0zRd20pTsdguhE=;
    b=Sd2iiqdIIk42EjQ70PI9TcGE9Z6py1KkoHWR1f2CcZLTNfFsg7PsGAh41XOgRjTXEu
    36+4L/LKFGhTFCsHpGJoeGsx+qmVEwsC4mDMFH0V3LawbCyzzEF41yowg4shS0actv3/
    IoMq+ghUoBLjDNLrsqoqFH/h1h+l897mjZIdBaDrwQrc8A91y4FTafDsqXZ1TJcAwpLe
    an5GlvfeivgQCrDMKICNC2CH35eQ96RgYV7amWrRzV6H2+WtH5c7cH3ogt+Vt36d4iro
    K2tPx1RGyT540Nts2/U9xeaf+VdSvRYtYcSMBvn9clYahLMKKYUzRVK73TGggzExri4I
    KoZA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKONebStI="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id e040b6x46Ha702b
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 May 2021 19:36:07 +0200 (CEST)
Subject: Re: [PATCH RFC] can: isotp: isotp_sendmsg(): return error on FC
 timeout on TX path
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Sottas Guillaume <Guillaume.Sottas@liebherr.com>
References: <20210506133622.1336101-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <97e2ddd5-cc8b-9c7b-6198-2eceee39dfd4@hartkopp.net>
Date:   Thu, 6 May 2021 19:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210506133622.1336101-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 06.05.21 15:36, Marc Kleine-Budde wrote:
> Link: https://github.com/hartkopp/can-isotp/pull/43
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Sottas Guillaume (LMB) <Guillaume.Sottas@liebherr.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hey Sottas,
> 
> can you check if this fixes your problem and that normal operation
> still works.
> 
> regards,
> Marc
> 
>   net/can/isotp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9f94ad3caee9..823f047a28ad 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -954,6 +954,9 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   	if (wait_tx_done) {
>   		/* wait for complete transmission of current pdu */
>   		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
> +
> +		if (sk->sk_err)
> +			return sk->sk_err;

That's a nice simple improvement.

But it has to be a negative value:

	return -sk->sk_err;

Your patch produces this:

$ date +%S.%N && ./isotpsend vcan0 -s 123 -d 321 -D 44 -b && date +%S.%N
55.587968123
retval 70 errno 0
wrote only 70 from 44 byte
56.594017244

With the negative value you get:

$ date +%S.%N && ./isotpsend vcan0 -s 123 -d 321 -D 44 -b && date +%S.%N
22.989331212
retval -1 errno 70
write: Communication error on send

Which we would need.

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

Many thanks,
Oliver
