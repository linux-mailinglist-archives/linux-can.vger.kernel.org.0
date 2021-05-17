Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B548382570
	for <lists+linux-can@lfdr.de>; Mon, 17 May 2021 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhEQHhs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 May 2021 03:37:48 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:31121 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhEQHhs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 May 2021 03:37:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621236991; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GptstSnOYWBoRn6PRvR5MBJl3rtxzUCFKqj3TEshX0oLjrHqWdNpQ1KpEcZ9nueio9
    hvLrV7o4WjV88AiF8Nr6aQATcNbN7tLODbvwezvMlxY7AacmfPquuAQXKrTmBwC0fIF2
    MhutiklGVk+0oWuuo+cBYwqiueuPWi3/fvcrIqHb37Y8AtImOKaIJfadbCJhKaydFvVv
    KY6/Oeh8oYbgQrwg41UGl/5nvIp6qhXEUQcQfvOK/RuxkcwYT5jyMS5vUBMWZWOXQbe7
    Ppnw/+b/9BMDWyFqlx8Ogs7xV59Fa81czD2rkcEvDyujgXbBX1fedP+TBEQ7VB/T7RMC
    j3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621236991;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=tH2QjFmz7xcNcp6EjvTezq0e2j15uMP6DNyvqBiPJj0=;
    b=KKJYmWKn0DC9AxiI1I5WmNgxueYwlnY1MJWUpzu0FQSsV98PE9pivg/t6CP2qQstHc
    xAVos+EYad22GnKj21UXEeX5deX8XuCdWPsHuaufsfjGjpyAlwobz8TjkJG47/d92NdD
    WQzMvc1F/0lz9E7qQBACr7bLdW267j9fkOEurSu4Yp6eN03j/l0w1HXoZAMLYMMQkvxu
    MQmB5w20zLgZD4P1T+YURUQdU6GP1NRwkfk4fil3PaqyCU2afaI12EDhL/ijvTab22h7
    U2cY2MSy3GjhyIzYN+OkmTtAsNZKe2bD2VSjmCLDL+RpUvo9A1xw99JnDwVYQNTE97+v
    RoHA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621236991;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=tH2QjFmz7xcNcp6EjvTezq0e2j15uMP6DNyvqBiPJj0=;
    b=KhmA8NQLUu2g23UTeJTBQLly8lykQ0ZNKgNWXqiS9FpvFSEBNC+za08/yCjZw3t5Tv
    ynToy265zXKO2AQpkocVWIU1Z0BTHizVgzxQnDhrpszBJrqgaqASVPM07q1VCYBQXSO9
    jNOee7kRqjZxyZfvPIF+9LYFCEdiDzNfS4oCd6qFle2R1BSS11T/wKLym1zG5w+hz/HM
    YmUz60WIVaD/eZtFrtbNLhbJc05isCasRVz2kiPBBa5UbgrDeo1fcI2xHlZ4UK828Wey
    hycA209B7CN3o8yV1wrpOZ23t+cIAxhOscAKhPQuPorCY1jhQ1ufomIEz2kUOY0Nfau+
    omXA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id C056fbx4H7aU11Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 09:36:30 +0200 (CEST)
Subject: Re: [PATCH v2 1/2] can: add support for filtering own messages only
To:     Erik Flodin <erik@flodin.me>
Cc:     linux-can@vger.kernel.org
References: <20210504203546.115734-1-erik@flodin.me>
 <20210504203546.115734-2-erik@flodin.me>
 <cf5fdb14-47e2-2d08-0d29-c621bff7b312@hartkopp.net>
 <CAAMKmocxj1zOQastSqKhHmV0-9HVh3NpPmSPWf=byxj+fFPUHQ@mail.gmail.com>
 <64bf5aaf-1e8c-2f29-8263-63710a771843@hartkopp.net>
 <CAAMKmoda0U912_6Qp97fzt4BjcbUPDrE8Cy5C7C-TS5_7du31Q@mail.gmail.com>
 <46bdff5c-c0ab-56e9-7c70-8a3267458d55@hartkopp.net>
 <CAAMKmocsZBsFfpRLyLHqFE94xb-xrm5S8YG=QzQTndDjtOyuzw@mail.gmail.com>
 <64e37aae-e6b5-20aa-04fb-10b4a2f50b5e@hartkopp.net>
 <CAAMKmocfkcFhhg+JgosbOVZD7AexWEwF6rJzN=Vv86WPFhQYyA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <df854f78-cd82-81b6-2456-b4c272920b6a@hartkopp.net>
Date:   Mon, 17 May 2021 09:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAAMKmocfkcFhhg+JgosbOVZD7AexWEwF6rJzN=Vv86WPFhQYyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 16.05.21 22:02, Erik Flodin wrote:

>> You mainly want to throttle the outgoing traffic, to make sure that e.g.
>> a specific CAN ID is not sent 'back-to'back' and might lead to a DoS
>> situation on the wire?!?
> 
> Yes, so after a frame has been sent, I want to leave the bus idle long
> enough to give another device on the bus that has something in its TX
> queue an opportunity to send.
> 
>> Do you know about the Linux CAN queuing disciplines that might provide
>> the solution to your question?
> 
> Yes, I came across that when I started my journey in CAN-land, but
> unfortunately the kernel I have to use doesn't have support for
> traffic control. That's when I started using RECV_OWN_MSGS which
> worked until I added filters and here we are now :)
> 
> If I get the chance to update the kernel (which would have to happen
> before my proposed patch could be used anyway) I should perhaps try to
> get tc support instead. That would simplify my application at least.

:-D

In any case it seems you need to change some kernel code.

The CAN frame ematch rule is from 2012:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f057bbb6f9ed0fb61ea11105c9ef0ed5ac1a354d

Is your kernel older than 2012? o_O
Or was TC just not enabled?

Best regards,
Oliver
