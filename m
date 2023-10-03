Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453777B6936
	for <lists+linux-can@lfdr.de>; Tue,  3 Oct 2023 14:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjJCMle (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Oct 2023 08:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJCMlc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Oct 2023 08:41:32 -0400
X-Greylist: delayed 175 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 05:41:29 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064FCAC
        for <linux-can@vger.kernel.org>; Tue,  3 Oct 2023 05:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696336707; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=o3FnDcWX+RnF8KkdXjd/x+bJ7Up0G0/ioR+cFy6XLyvNFM0uNR0aD6nbbz3pfUO37s
    a3IDs3lCW8Ip5B8C/9Tp3veV6zAv/xc0yZy8vBT4bPN93OIcd7Q3fjgQr4E+usAQ/Wxj
    /7dATkkcyO5DTE3IQeijdVNbmt8tc+BSdutDgBysFVzR+U/NSv/40DBTHsQ/c8T1MagI
    ctmDKAE3iqZIHkr5kfINEy5YoKghnvkTPs6R3wHvePi0R0ZclGzA55hBGJhLVWMzvX0g
    sw+/uLkrRDqRXQifMVKlN2sAo8rbUuLHZcp+bIhFrc6039k/DX1cbhHM/8nFrydNObym
    wc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696336707;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MBaDvNdgWhpWdbeHxrq4aobhdhXKP5Pa07Rrl02JIIw=;
    b=HQrTwT+oOXxklfPHBPvWyqS9iD5WPHDwyHENR4yU8EaX5XzkfOCdmpm2BhT8YZbM3o
    NpD6Pat+9OgoPxyxKGWYoN2ah8Yr7dHtFZHoO+MLD7OiHgVLklU6Ut459yoUdpdx1F74
    lteHpk8yvdIH+Qm3LgmfBeVNcOCaEUG9a4y/zT+tFjg2T0qAq95/Io32a9xBMNvEcxdp
    DarvYP6552bUeav5mgew05ouSzeOKtKzMg48NOV8V2GOSJ9PhaCJGQ41h11Pt2859EEe
    DTOHyUUywwaV8J2I4Ve+uj5SgGAVRhoW4HDwQmOYKpn9WIduI3i+r7462MGoPW1dClwJ
    g6fw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696336707;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MBaDvNdgWhpWdbeHxrq4aobhdhXKP5Pa07Rrl02JIIw=;
    b=Oez/orDeYTvKKWIQaxl5E0uMtZvJfAu/klHTF52ixuF1SwZbjGgZfl8TErw2+rhgQh
    BvaIYNG8fzgcxByv0MYoKsg8qb+XgjBb1g7iYXR/Y4GhfIA6GCKc4Uhs7EyxtmbulQll
    AlSInpH82VK2Q77k9AbvlpMOu1F2gHJx/9AL0vq4c42O/kQHzFaVANkKAWw2RQJeoVPy
    t/UL4dtw9YGndraj1O07sEF0IYeENZ25lIp+HvhcaX+PB6rWf0G9warRwwI9dENNe84b
    U5igtiXgRWOee/DQaL5vG4RFtTIh3TyXKJYcBI/wWLmUNxehRzccxoQkT+gIfR929Tc8
    RvIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696336707;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MBaDvNdgWhpWdbeHxrq4aobhdhXKP5Pa07Rrl02JIIw=;
    b=hgHRREhp99cMWhZA1EcSbnroP6hfYYq8TlHdkwYZrTnwdmcF/+PF05urCH2eV7ONtn
    iVf7h8sWx53+TOlR7XBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1onXMb0WM++sEwsmZtg=="
Received: from [192.168.23.131]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id j046cdz93CcRoSL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 14:38:27 +0200 (CEST)
Message-ID: <74a8b3a6-158d-58b9-532a-aa8edd73d6c6@hartkopp.net>
Date:   Tue, 3 Oct 2023 14:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] can: isotp: isotp_sendmsg(): fix TX state detection
 and wait behavior
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Lukas Magel <lukas.magel@posteo.net>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>
References: <20230818114345.142983-1-lukas.magel@posteo.net>
 <20230827092205.7908-1-lukas.magel@posteo.net>
 <96d31e8c-fa26-4e32-4c36-768981f20a54@hartkopp.net>
Content-Language: en-US
In-Reply-To: <96d31e8c-fa26-4e32-4c36-768981f20a54@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hallo Marc,

can you please upstream this fix?

I just did not monitor the upstream but got back to this patch due to a 
discussion on GitHub:

https://github.com/pylessard/python-udsoncan/issues/178#issuecomment-1743786590

Thanks & best regards,
Oliver


On 2023-08-27 14:19, Oliver Hartkopp wrote:
> Thanks Lukas!
> 
> On 27.08.23 11:22, Lukas Magel wrote:
>> With patch [1], isotp_poll was updated to also queue the poller in the
>> so->wait queue, which is used for send state changes. Since the queue
>> now also contains polling tasks that are not interested in sending, the
>> queue fill state can no longer be used as an indication of send
>> readiness. As a consequence, nonblocking writes can lead to a race and
>> lock-up of the socket if there is a second task polling the socket in
>> parallel.
>>
>> With this patch, isotp_sendmsg does not consult wq_has_sleepers but
>> instead tries to atomically set so->tx.state and waits on so->wait if it
>> is unable to do so. This behavior is in alignment with isotp_poll, which
>> also checks so->tx.state to determine send readiness.
>>
>> V2:
>> - Revert direct exit to goto err_event_drop
>>
>> [1] 
>> https://lore.kernel.org/all/20230331125511.372783-1-michal.sojka@cvut.cz
>>
>> Reported-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
>> Closes: 
>> https://lore.kernel.org/linux-can/11328958-453f-447f-9af8-3b5824dfb041@munic.io/
>> Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
> 
> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Fixes: 79e19fa79cb5 ("can: isotp: isotp_ops: fix poll() to not report 
> false EPOLLOUT events")
> 
> I would suggest to add this Fixes tag here to give a qualified hint 
> since when it makes sense to apply this patch from Lukas. It definitely 
> fixes the introduced isotp_poll() function from Michal.
> 
> Btw. before the patch from Michal the poll() syscall was completely 
> brocken o_O
> 
> Many thanks to all of you!
> 
> Best regards,
> Oliver
> 
>>
>> ---
>>
>>   net/can/isotp.c | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 99770ed285..61caf48cf7 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -954,21 +954,18 @@ static int isotp_sendmsg(struct socket *sock, 
>> struct msghdr *msg, size_t size)
>>       if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
>>           return -EADDRNOTAVAIL;
>> -wait_free_buffer:
>> -    /* we do not support multiple buffers - for now */
>> -    if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
>> -        return -EAGAIN;
>> +    while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != 
>> ISOTP_IDLE) {
>> +        /* we do not support multiple buffers - for now */
>> +        if (msg->msg_flags & MSG_DONTWAIT)
>> +            return -EAGAIN;
>> -    /* wait for complete transmission of current pdu */
>> -    err = wait_event_interruptible(so->wait, so->tx.state == 
>> ISOTP_IDLE);
>> -    if (err)
>> -        goto err_event_drop;
>> -
>> -    if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != 
>> ISOTP_IDLE) {
>>           if (so->tx.state == ISOTP_SHUTDOWN)
>>               return -EADDRNOTAVAIL;
>> -        goto wait_free_buffer;
>> +        /* wait for complete transmission of current pdu */
>> +        err = wait_event_interruptible(so->wait, so->tx.state == 
>> ISOTP_IDLE);
>> +        if (err)
>> +            goto err_event_drop;
>>       }
>>       /* PDU size > default => try max_pdu_size */
