Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BBA6C9404
	for <lists+linux-can@lfdr.de>; Sun, 26 Mar 2023 13:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCZLiV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Mar 2023 07:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZLiU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Mar 2023 07:38:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898963C34
        for <linux-can@vger.kernel.org>; Sun, 26 Mar 2023 04:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679830697; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MUXkW8kkOfK9Nqz5UwcYqjvT1y5iYLLoGP6vQQG51Al6iqXFN9KAHaRIDAA/yHtKqn
    Sx5LdPoeiBQqBnQgQ5mPSqNsZYY1TaVlKbePdszhpyhBheXuUz7tZRoBW8/i7AATY/e3
    CdNfSFIXc+paEN8bot5BaBZjUCmtSd2tB5srWFt2z0mn5ZbHCGp0jN69MVoMHejeJlBx
    XK3f8EZb90D6zr53j6EC8ufefhZNhvxTsuCwGl9SO699hwc+bh+R6XgtdJBX87CXUGYM
    R2w9uCrHQ2YHhWOfI0uplgT2pwe/MGKztYvPX/3XAFLB9psWtIsbYvbvHqDkwhVi1RDJ
    uNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679830697;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZgWCGpDkvEnu35Thij4OfibFURCeEymlhnTAH83PCH8=;
    b=LAddirO3gCCDpjyschOm7EJuJWoCTWv4ATpC5AL9t/Cx0ANlXCdAsGtspMm8btKtiK
    2E5fRw8l6GTNMQimpeoKM5N3xbu9WBOmmnzQk61crPk7uv61cdpCE1Ag3jDEsgIJu2W0
    IfRRFowYidEFfKeUUlKG7JyKiNzaF2qWpYVLcCEHoWLraC6gKHGJsi45+OGNxHu6Eef8
    9LiyCYtdba8YalR6QTezJTnBNfvZkV+UYEPj2SusQnVId7mSM2LVAfhvjCXQNtkWU9Se
    c5ZRO6fChxEo1lDEWzoGCpW6+f0NzowQFiblQEV4Q8ZtT/P7AYy0SDQtqYUscd/W1H5i
    8lqg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679830697;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZgWCGpDkvEnu35Thij4OfibFURCeEymlhnTAH83PCH8=;
    b=SGbjjwB81YcOHPf+mHj98+i9cj0Zb8M2tmOQ5b193YJjubjLJdQuwxJbqnJkQw30Fr
    /tImGfPTV8OfrEY7BHEuWNNeHXJLBJDmJRbfFMHR8fQVqm/tiStSmPHBGyua0v51nzJS
    Gmk5NfbbEAOt3evA1zNbpETx6n1VJp9auoR1TDwrzHan320pUO8UqfHBWGLBk870GgcM
    VBHHAqIAq+7o4Q7yIRQvKG9Zl2soZTcl9/SyZ8Q19PRDtT4pCjnUlDyYw4lleelta0P+
    mJUdpA0gwdK5rAQXKleTJeyOr0VlokoxjAltkWMRi6A6eVFy/8X7K8DJYEhPyJv0XwDu
    Oqlg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2QBcGSEc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 26 Mar 2023 13:38:16 +0200 (CEST)
Message-ID: <48552283-9481-8877-afb4-24aba862a49e@hartkopp.net>
Date:   Sun, 26 Mar 2023 13:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v2] can: isotp: fix poll() to not report false
 EPOLLOUT events
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Michal Sojka <michal.sojka@cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Jakub Jira <jirajak2@fel.cvut.cz>
References: <20230302092812.320643-1-michal.sojka@cvut.cz>
 <20230324175040.hxsd3avlvddoemqz@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230324175040.hxsd3avlvddoemqz@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 24.03.23 18:50, Marc Kleine-Budde wrote:
> Oliver, what about this patch?
> 

the latest discussion on this topic was this answer from Michal ...

https://lore.kernel.org/linux-can/87mt4tu4ow.fsf@steelpick.2x.cz/T/#u

... which somehow ended there.

After getting and answering this mail today:

https://lore.kernel.org/linux-can/31c4a218-ee1b-4b64-59b6-ba5ef6ecce3c@hartkopp.net/T/#t

... I would try the V2 patch for poll() function after applying the 
lock_sock() patch suggested there.

Best regards,
Oliver

> 
> On 02.03.2023 10:28:12, Michal Sojka wrote:
>> When using select/poll/epoll() with a non-blocking ISOTP socket to
>> wait for when non-blocking write is possible, false EPOLLOUT event is
>> sometimes returned. This can happen at least after sending a message
>> which must be split to multiple CAN frames.
>>
>> The reason is that isotp_sendmsg() returns -EAGAIN when tx.state is
>> not equal to ISOTP_IDLE and this behavior is not reflected in
>> datagram_poll(), which is used in isotp_ops.
>>
>> This is fixed by introducing ISOTP-specific poll function, which
>> suppresses the EPOLLOUT events in that case.
>>
>> This can be tested with a program available at
>> https://github.com/wentasah/isotp-poll-test/blob/fd095b2242c49dc5d3e36faf5ac9f4f47fd002c7/isotp-poll-test.c
>> which can trigger the problem on a vcan interface. When running the
>> program as:
>>
>>      ./isotp-poll-test -s 123 -d 321 -o
>>
>> it starts sending ISOTP messages that include increasing ASCII
>> numbers. poll() is used to wait before the next transmission.
>>
>> With current mainline Linux, once the message length is greater than 7
>> bytes, write() returns -EAGAIN and the program terminates. This should
>> not happen, because the previous poll() reported that the write()
>> would not block.
>>
>> After applying this patch, the above command doesn't fail - if one
>> runs some ISOTP reader such as:
>>
>>      isotprecv -l -s 321 -d 123 vcan0
>>
>> This test program can also show another problem. When running:
>>
>>      ./isotp-poll-test -s 321 -d 123 -i -a
>>
>> and then in another terminal:
>>
>>      ./isotp-poll-test -s 123 -d 321 -o
>>
>> The first program receives the messages and uses the counter values to
>> check for lost messages. After a random number of iterations a lost
>> message is always detected. I believe that ISOTP should be reliable
>> protocol, at least on vcan, shouldn't it?
>>
>> Anyway, this patch doesn't try to address this problem.
>>
>> Signed-off-by: Michal Sojka <michal.sojka@cvut.cz>
>> Reported-by: Jakub Jira <jirajak2@fel.cvut.cz>
>>
>> ---
>> Changelog:
>>
>> v2: Added waiting for isotp-specific wait queue: poll_wait(file, &so->wait, wait).
>> ---
>>   net/can/isotp.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 9bc344851704..ec163e36ac53 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1608,6 +1608,21 @@ static int isotp_init(struct sock *sk)
>>   	return 0;
>>   }
>>   
>> +static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *wait)
>> +{
>> +	struct sock *sk = sock->sk;
>> +	struct isotp_sock *so = isotp_sk(sk);
>> +
>> +	__poll_t mask = datagram_poll(file, sock, wait);
>> +	poll_wait(file, &so->wait, wait);
>> +
>> +	/* Check for false positives due to TX state */
>> +	if ((mask & EPOLLWRNORM) && (so->tx.state != ISOTP_IDLE))
>> +		mask &= ~(EPOLLOUT | EPOLLWRNORM);
>> +
>> +	return mask;
>> +}
>> +
>>   static int isotp_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
>>   				  unsigned long arg)
>>   {
>> @@ -1623,7 +1638,7 @@ static const struct proto_ops isotp_ops = {
>>   	.socketpair = sock_no_socketpair,
>>   	.accept = sock_no_accept,
>>   	.getname = isotp_getname,
>> -	.poll = datagram_poll,
>> +	.poll = isotp_poll,
>>   	.ioctl = isotp_sock_no_ioctlcmd,
>>   	.gettstamp = sock_gettstamp,
>>   	.listen = sock_no_listen,
>> -- 
>> 2.39.2
>>
>>
> 
