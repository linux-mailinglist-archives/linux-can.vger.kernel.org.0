Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA52980DD
	for <lists+linux-can@lfdr.de>; Sun, 25 Oct 2020 09:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414633AbgJYIt5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Oct 2020 04:49:57 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:32048 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414631AbgJYIt5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Oct 2020 04:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603615791;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=QZkFsl3CFayT4Leb48SI40IP44Bs8FfggbPYtlR6vHg=;
        b=dgM2nMgKublmyU+ubBETkf4iQLxkJKaH/74xmZrmdYFSQEO+w59lCbfr4cgG9jTvnt
        CGC7zANWxKtmoFnwexLfv5L0LgobzjXSANEuhGDWsldUDh4j8xBw8vH8CXBP646sXeEJ
        jXkc9Sdch2qvT1ZsC3wasxmfQ+mhWQcDJaaUY8D19T6BU6TMU5ezBke0sXwnGcO3Wmgq
        QohFwN8sQUuMWcna9o28HwMeJd9BFJn09nkUK6D15RwYvnAvu0GyMcCP78n2jyiw+3bU
        zSKY6KVsChsh3crJshI1ryKfCvHqISaeZ/R7cbCCpQUsmLXFx/iXfkUGq0B5HlJIPjJc
        4/bQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT5L33lT8qMWw="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9P8nl1g1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 25 Oct 2020 09:49:47 +0100 (CET)
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Drew Fustini <drew@beagleboard.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj5HwFUTqhbgZ2Y5Db-_PPHNN7Rc8dnp1s+TBBALf5EwSw@mail.gmail.com>
 <3ede1c31-9436-a8ec-b7cd-65cee5fa23fc@pengutronix.de>
 <CAPgEAj7JLUjWiN8LdGV9OfQScsUkPVcs9bSE+w_9G0c9BNd-sg@mail.gmail.com>
 <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <975a3598-c229-0b9a-df95-c9647f138a3a@hartkopp.net>
Date:   Sun, 25 Oct 2020 09:49:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 25.10.20 05:30, Drew Fustini wrote:
> On Thu, Oct 22, 2020 at 1:42 PM Drew Fustini <drew@beagleboard.org> wrote:
>>
>> On Thu, Oct 22, 2020 at 1:33 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>
>>> On 10/22/20 8:00 AM, Drew Fustini wrote:
>>>> It appears it was simpler to get it to compile than I expected.
>>>
>>> \o/
>>>
>>>> cs_change_delay.unit becomes cs_change_delay_unit,  and
>>>> cs_change_delay.value becomes cs_change_delay.
>>>>
>>>> The other issue was 728fc9ff73d3 ("can: rx-offload:
>>>> can_rx_offload_add_manual(): add new initialization function") which
>>>> was simply solved by adding can_rx_offload_add_manual() to:
>>>> include/linux/can/rx-offload.h
>>>> drivers/net/can/rx-offload.c
>>>>
>>>> The driver builds ok:
>>>
>>> With your help :) I backported current linus/master to the rpi-5.4:
>>>
>>> https://github.com/marckleinebudde/linux/tree/v5.4-rpi/mcp251xfd-20201022-54
>>>
>>> Can you test that?
>>
>> Thanks, will do.   I am currently trying to finish up my ELC-E talk
>> prep :) but will get back to you with the results of testing later.
> 
> I noticed up doing a modprobe that there are several Unknown symbol errors.
> 
> Any ideas?
> 
> [  358.686691] mcp251xfd: Unknown symbol can_rx_offload_del (err -2)
> [  358.686744] mcp251xfd: Unknown symbol can_put_echo_skb (err -2)
> [  358.686796] mcp251xfd: Unknown symbol can_len2dlc (err -2)
> [  358.686844] mcp251xfd: Unknown symbol alloc_canfd_skb (err -2)
> [  358.686942] mcp251xfd: Unknown symbol open_candev (err -2)
> [  358.687042] mcp251xfd: Unknown symbol alloc_can_skb (err -2)
> [  358.687093] mcp251xfd: Unknown symbol unregister_candev (err -2)
> [  358.687139] mcp251xfd: Unknown symbol can_change_state (err -2)
> [  358.687183] mcp251xfd: Unknown symbol can_change_mtu (err -2)
> [  358.687227] mcp251xfd: Unknown symbol can_rx_offload_add_manual (err -2)
> [  358.687294] mcp251xfd: Unknown symbol free_candev (err -2)
> [  358.687345] mcp251xfd: Unknown symbol alloc_candev_mqs (err -2)
> [  358.687416] mcp251xfd: Unknown symbol close_candev (err -2)
> [  358.687475] mcp251xfd: Unknown symbol can_bus_off (err -2)
> [  358.687519] mcp251xfd: Unknown symbol can_rx_offload_enable (err -2)
> [  358.687569] mcp251xfd: Unknown symbol can_rx_offload_get_echo_skb (err -2)
> [  358.687656] mcp251xfd: Unknown symbol can_dlc2len (err -2)
> [  358.687710] mcp251xfd: Unknown symbol alloc_can_err_skb (err -2)
> [  358.687773] mcp251xfd: Unknown symbol can_rx_offload_queue_sorted (err -2)
> [  358.687819] mcp251xfd: Unknown symbol register_candev (err -2)
> [  369.092608] CAN device driver interface

The can-dev module has been loaded *after* mcp251xfd.

Don't know why autoloading did not work on your machine but doing a 
'modprobe can-dev' before loading the MCP driver should do it for a test.

Best,
Oliver

> 
> root@raspberrypi:~# modinfo mcp251xfd
> filename:
> /lib/modules/5.4.72-v7l+/kernel/drivers/net/can/spi/mcp251xfd/mcp251xfd.ko
> license:        GPL v2
> description:    Microchip MCP251xFD Family CAN controller driver
> author:         Marc Kleine-Budde <mkl@pengutronix.de>
> srcversion:     1E05EEB5939E9AB22BA2E1B
> alias:          spi:mcp251xfd
> alias:          spi:mcp2518fd
> alias:          spi:mcp2517fd
> alias:          of:N*T*Cmicrochip,mcp251xfdC*
> alias:          of:N*T*Cmicrochip,mcp251xfd
> alias:          of:N*T*Cmicrochip,mcp2518fdC*
> alias:          of:N*T*Cmicrochip,mcp2518fd
> alias:          of:N*T*Cmicrochip,mcp2517fdC*
> alias:          of:N*T*Cmicrochip,mcp2517fd
> depends:        can-dev
> intree:         Y
> name:           mcp251xfd
> vermagic:       5.4.72-v7l+ SMP mod_unload modversions ARMv7 p2v8
> 
> root@raspberrypi:~# lsmod |grep mcp
> mcp251xfd              36864  0
> can_dev                28672  1 mcp251xfd
> 
> 
> Thanks,
> Drew
> 
