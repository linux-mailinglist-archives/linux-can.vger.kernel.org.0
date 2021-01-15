Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F82F7BA0
	for <lists+linux-can@lfdr.de>; Fri, 15 Jan 2021 14:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbhAONEN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jan 2021 08:04:13 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:17047 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbhAONEM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jan 2021 08:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610715677;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=sayPzAdvpstKzH8RYSbIqms91+XSsNmNVidATQ0aIys=;
        b=gd9q3Ebl5P1vdNAgO91BeKnpMsuWPg+B/E6Ucy61XLTJXOkXDRcSt4O1i9mfhb17Ty
        qVcOCFbq1a84Dj1KJV/J4E7b8a/lzAXE+ryiqzmHJXNhDlRiq1ZdMTU7T9HPUKMQxkbT
        z1WUyOu7+71ylracN76JgvNDZx+JKzq5bo4CQe/qnAlzQEXgQq7DSBp5dFz01dpwiu0T
        AmglZc7aNmpz+hYCdYEdwtNt9fX6CgRAjy0NNAmr3WHYQ/Z8Xv+SG3KDKYS8CcbUJ49z
        llhydY4A0/d6IOjRHgaaREPSYEfSWte3WLSWPviz9zmdo24BCe+V31h1r5hLORRC3bCk
        jPsw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVJiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0FD1EX2z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 15 Jan 2021 14:01:14 +0100 (CET)
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr>
 <981eb251-1573-5852-4b16-2e207eb3c4da@hartkopp.net>
 <CAMZ6RqKeGVsF+CcqoAWC7JXEo2oLTS5E5B3Jk4oeiF9XWEC3Sw@mail.gmail.com>
 <3daf39cb-2835-379d-86df-91b17282594a@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <47a39992-2368-1403-e55c-3bee4793b91c@hartkopp.net>
Date:   Fri, 15 Jan 2021 14:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3daf39cb-2835-379d-86df-91b17282594a@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

-DaveM
-JacubK
-netdev

@Vincent: No need for cross posting and putting the networking 
maintainers in CC for these really deep CAN driver specific topics IHMO

On 15.01.21 08:26, Marc Kleine-Budde wrote:
> On 1/15/21 1:41 AM, Vincent MAILHOL wrote:
>> On Fri. 15 Jan 2021 at 02:23, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>
>>> Hi Vincent,
>>>
>>> On 12.01.21 14:05, Vincent Mailhol wrote:
>>>> This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
>>>> ETAS GmbH (https://www.etas.com/en/products/es58x.php).
>>>
>>> (..)
>>>
>>>> diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
>>>> new file mode 100644
>>>> index 000000000000..6b9534f23c96
>>>> --- /dev/null
>>>> +++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
>>>
>>> (..)
>>>
>>>> +static void es58x_fd_print_bittiming(struct net_device *netdev,
>>>> +                                  struct es58x_fd_bittiming
>>>> +                                  *es58x_fd_bittiming, char *type)
>>>> +{
>>>> +     netdev_vdbg(netdev, "bitrate %s    = %d\n", type,
>>>> +                 le32_to_cpu(es58x_fd_bittiming->bitrate));
>>>> +     netdev_vdbg(netdev, "tseg1 %s      = %d\n", type,
>>>> +                 le16_to_cpu(es58x_fd_bittiming->tseg1));
>>>> +     netdev_vdbg(netdev, "tseg2 %s      = %d\n", type,
>>>> +                 le16_to_cpu(es58x_fd_bittiming->tseg2));
>>>> +     netdev_vdbg(netdev, "brp %s        = %d\n", type,
>>>> +                 le16_to_cpu(es58x_fd_bittiming->brp));
>>>> +     netdev_vdbg(netdev, "sjw %s        = %d\n", type,
>>>> +                 le16_to_cpu(es58x_fd_bittiming->sjw));
>>>> +}
>>>
>>> What is the reason for this code?
>>>
>>> These values can be retrieved with the 'ip' tool and are probably
>>> interesting for development - but not in the final code.
>>
>> First thing, I used netdev_vdbg() (verbose debug). That macro
>> will only produce code if VERBOSE_DEBUG is defined. Normal users
>> will not see those. So yes, this is mostly for development.
>>
>> Also, just realised that netdev_vdbg() is barely used
>> anywhere (only three files use it:
>> https://elixir.bootlin.com/linux/v5.11-rc3/C/ident/netdev_vdbg).
>>
>> I guess that I will remove it :)
>>

Thanks! That will remove some more code in the background too.

>>>> +
>>>> +static void es58x_fd_print_conf(struct net_device *netdev,
>>>> +                             struct es58x_fd_tx_conf_msg *tx_conf_msg)
>>>> +{
>>>> +     es58x_fd_print_bittiming(netdev, &tx_conf_msg->nominal_bittiming,
>>>> +                              "nominal");
>>>> +     netdev_vdbg(netdev, "samples_per_bit    = %d\n",
>>>> +                 tx_conf_msg->samples_per_bit);
>>>> +     netdev_vdbg(netdev, "sync_edge          = %d\n",
>>>> +                 tx_conf_msg->sync_edge);
>>>> +     netdev_vdbg(netdev, "physical_layer     = %d\n",
>>>> +                 tx_conf_msg->physical_layer);
>>>> +     netdev_vdbg(netdev, "self_reception     = %d\n",
>>>> +                 tx_conf_msg->self_reception_mode);
>>>> +     netdev_vdbg(netdev, "ctrlmode           = %d\n", tx_conf_msg->ctrlmode);
>>>> +     netdev_vdbg(netdev, "canfd_enabled      = %d\n",
>>>> +                 tx_conf_msg->canfd_enabled);
>>>> +     if (tx_conf_msg->canfd_enabled) {
>>>> +             es58x_fd_print_bittiming(netdev,
>>>> +                                      &tx_conf_msg->data_bittiming, "data");
>>>> +             netdev_vdbg(netdev,
>>>> +                         "Transmitter Delay Compensation        = %d\n",
>>>> +                         tx_conf_msg->tdc);
>>>> +             netdev_vdbg(netdev,
>>>> +                         "Transmitter Delay Compensation Offset = %d\n",
>>>> +                         le16_to_cpu(tx_conf_msg->tdco));
>>>> +             netdev_vdbg(netdev,
>>>> +                         "Transmitter Delay Compensation Filter = %d\n",
>>>> +                         le16_to_cpu(tx_conf_msg->tdcf));
>>>> +     }
>>>> +}
>>>
>>> Same here.
>>>
>>> Either the information can be retrieved with the 'ip' tool OR the are
>>> not necessary as set to some reasonable default anyway
>>
>> Ack, will remove.
>>
>>> OR we should
>>> implement the functionality in the general CAN driver infrastructure.
>>
>> Would make sense to me to add the tdco (Transmitter Delay
>> Compensation Offset). Ref: ISO 11898-1 section
>> 11.3.3 "Transmitter delay compensation"
>>
>> I would just like your opinion on one topic: the tdco is specific
>> to CAN FD. If we add it, we have two choices:
>>    1. put it in struct can_bittiming: that will mean that we will
>>       have an unused field for classical CAN (field bittiming of
>>       struct can_priv).
>>    2. put it in struct can_priv (but outside of struct
>>       can_bittiming): no unused field but less pretty.
> 
> 3. Deprecate struct can_bittiming as the user space interface
>     and transfer each member individually via netlink. Extend
>     the kernel-only can_bittiming by the tdc related
>     parameters, and add these to the new netlink interface.

I also saw the current netlink interface as the problem here.

But even when 'deprecating' the old interface we still need to provide 
the API, right?

Would therefore the new parameters overwrite the content which is 
transferred by can_bittiming or how would you like to make sure the 
mixed content remains consistent?

> I prefer this, as I want to extend the bittiming_const in this way, too. There
> are CAN controllers, where the bit timing calculation:
> 
>> 	bt->prop_seg = tseg1 / 2;
>> 	bt->phase_seg1 = tseg1 - bt->prop_seg;
> 
> doesn't work anymore, as they have asymmetric prog_seg and phase_seg1, so that
> splitting tseg1 in half doesn't work anymore.

Interesting.

Regards,
Oliver
