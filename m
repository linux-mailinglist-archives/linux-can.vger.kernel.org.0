Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B9540AD3A
	for <lists+linux-can@lfdr.de>; Tue, 14 Sep 2021 14:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhINMOg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 14 Sep 2021 08:14:36 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:32311 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhINMOd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Sep 2021 08:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1631621590;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GDd1840l+atKp1NAMq0aDohXW4/u0haN9p1jfeN+yKI=;
    b=GOiKF9ghg+QPoGprP49xbyQgmB9KYf+YyyH5Q21ShQ1yxFYctWjl6oCPdYripE6kWt
    QhkcZeCFU6J2x1WbjEOKKoQT2Xs2nSjCWPTqpstAFIe7IF20k14wIPqM/3C/kfrjIL4l
    KbqN+p/FNOT/TXVSWQJU8qoCIolgunFwvUb7ts5ODCoFQE1xmWcGPwlwKxXtpCxx44hQ
    seudMrchpHhxQ/+DnxpMpcfJbCurpoLno/H005SPdXDRvX51Lfn6PK22514P8h7+rhTM
    2bOOu+2WKaqOFsQWh5EFm34v1lo9rTSHrF/KankipRGtmjV6tPGf9w4Z0Fd1mNI9jxOa
    uqJw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GPy/OhvRKit2qa/q71YyZKdnOgIKH7DT4j3cUFRQm0abs="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:20:d055:1d98:a712:39b8:66d3:7a8b]
    by smtp.strato.de (RZmta 47.33.3 AUTH)
    with ESMTPSA id 309acbx8ECDABaQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 14 Sep 2021 14:13:10 +0200 (CEST)
Subject: Re: [PATCH v3 1/2] can: netlink: prevent incoherent can configuration
 in case of early return
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <20210906160310.54831-1-mailhol.vincent@wanadoo.fr>
 <20210906160310.54831-2-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqJaY_jRv+AZ6oH6rxP=dE9Vs1fBwhBQJq_o3dgMWM1vUg@mail.gmail.com>
 <bccb03f4-5179-895a-f803-5adf543a8c19@hartkopp.net>
 <CAMZ6RqKpiYOLn7=NoN1U4PwnW4fdrJ1N57nGrCJ6FgKnyx5GvQ@mail.gmail.com>
 <CAMZ6RqJa1+nNyoaGE7Phs3YSAMKEpYC8m=Ho7W3_XwcWdxdu5w@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <961e6361-f79e-5fd8-14eb-93768919a43f@hartkopp.net>
Date:   Tue, 14 Sep 2021 14:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJa1+nNyoaGE7Phs3YSAMKEpYC8m=Ho7W3_XwcWdxdu5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 14.09.21 13:45, Vincent MAILHOL wrote:

>> However, one driver fails to check the return value of open_candev():
>> https://elixir.bootlin.com/linux/v5.11/source/drivers/net/can/softing/softing_fw.c#L636
>>
>> So, for this particular driver, we can send incoherent values to the device.
>>
>>> The code with all the sanity checks is already pretty complex IMO.
>>
>> ACK.
>>
>>> I wonder if this effort is worth it.
>>
>> Well, I was thinking "this is a bug so let's fix it". But your
>> argument is fair. I also did not like how complex the code was
>> getting when trying to fix that. I guess that this bug is
>> acceptable. I will leave it as it is.
>>
>> Now, I am just worried about the softing driver.

IMO this should not be a problem.

The code is only used for a *restart* of the CAN interface. Therefore 
the bitrates have been checked at the original (first) start.

> Actually, the softing driver is not CAN-FD capable.
> So there was probably no real needs to worry.

Yes. I luckily checked the other mails in the inbox before answering 
that ;-)

Best,
Oliver
