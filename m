Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C4A302B36
	for <lists+linux-can@lfdr.de>; Mon, 25 Jan 2021 20:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbhAYTLK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 25 Jan 2021 14:11:10 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:10273 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731540AbhAYTLC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jan 2021 14:11:02 -0500
Received: from [100.113.6.195] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id 6B/3C-33844-AC61F006; Mon, 25 Jan 2021 19:06:50 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRWlGSWpSXmKPExsUS8J9tou5JMf4
  Eg2VvbSxWfZ/KbPF2dwuTxfpFU1gslt7byerA4vHx0m1Gj/6/Bh6fN8l5fL67njWAJYo1My8p
  vyKBNePqll0sBT12FftW7GJsYPyu38XIxSEk0MAosXfKHtYuRk4OCQE/iXcTD7NBJNYwSvRN7
  2MGSQgJ7GWU+LkNzBYWCJBoOXOHHcQWEYiU2LRrFztIA7PAJKCGXStZIbq3MUk0nN0F1sEmYC
  ax/sUzMJtXwFZi043/LCA2i4CqxMZL/8FWiwpESCzc38kKUSMocXLmE7AaTgEniUeP2oB6OYA
  2aEqs36UPEmYWEJe49WQ+E4StLbFs4WuoQzUl1pxawwzxjYLEpFlPmUBaJQTiJL7cMYUwrSUm
  bk6EqFCTmL+4ixHC5pR4/+ED0wRG8VlIbpiFsHcWkr2zkOxdwMiyitEyqSgzPaMkNzEzR9fQw
  EDX0NBY11zXyNRIL7FKN0kvtVQ3OTWvpCgRKKuXWF6sV1yZm5yTopeXWrKJERi3KYXsf3YwXn
  /9Qe8QoyQHk5Iob8AjvgQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErziovwJQoJFqempFWmZOcA
  UApOW4OBREuGdIAKU5i0uSMwtzkyHSJ1i1OW4+X7JImYhlrz8vFQpcd59IDMEQIoySvPgRsDS
  2SVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwryLQabwZOaVwG16BXQEE9ART87wgRxRkoiQk
  mpgunB3uuMatQnL29ftTihktUrLiPq7t7BF/myj6PfvbcuTzB/meMRoH+ILndM/MXfPK6E5W9
  VXnWVQSKh5eaul88HiCSt+/pT2O7qxQO5E5cHo61w2y/ukrkQH/OyX+je52VRwQp68+kKWeYt
  yXT+dtxDNOpnK8jTxbfGfVcmzvvnYJj1lnMg6NSb/3keJGzwBpximrbPKOzn/5tpFVhElgkfP
  Hll8ao/7v5VR126L37ZOZ/jvbnqjNU9Grfviy8CHz2PqUqd/eXxOw2/SdRUGO7G5VV/f/k3Oa
  Vo2NyhuZriMS/IF1TOWs4zalbaGzA5yWCL7NclktZuy8g/hSB/5tFOFkxI+HPtTulB0U3iTrB
  JLcUaioRZzUXEiAPdWZB3iAwAA
X-Env-Sender: Abhijeet.Badurkar@duagon.com
X-Msg-Ref: server-21.tower-239.messagelabs.com!1611601609!2107424!1
X-Originating-IP: [80.255.6.145]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20643 invoked from network); 25 Jan 2021 19:06:49 -0000
Received: from unknown (HELO keys.men.de) (80.255.6.145)
  by server-21.tower-239.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 25 Jan 2021 19:06:49 -0000
Received: from MEN-EX01.intra.men.de ([192.168.1.1])
  by keys.men.de (PGP Universal service);
  Mon, 25 Jan 2021 20:06:49 +0100
X-PGP-Universal: processed;
        by keys.men.de on Mon, 25 Jan 2021 20:06:49 +0100
Received: from MEN-EX01.intra.men.de (192.168.1.1) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 20:06:48 +0100
Received: from [10.64.14.204] (10.64.14.204) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 20:06:47 +0100
Subject: Re: [PATCH v6] net: can: Introduce MEN 16Z192-00 CAN controller
 driver
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        linux-can <linux-can@vger.kernel.org>,
        <andreas.geissler@duagon.com>, <stefan.schlosser@duagon.com>
References: <20210122110533.2728-1-abhijeet.badurkar@duagon.com>
 <CAMZ6Rq+MPpknpxwKv0-eV8J3FbKw7AigWrzbMC1HJgEUv8f56A@mail.gmail.com>
 <0673cb4c-f6ce-027c-8028-62161ca47f9c@duagon.com>
 <CAMZ6RqLLU2BC1m_F8Dfi9_n_AoQ6CgfOgtY3xwTscdLvJN4+Ag@mail.gmail.com>
 <b50ee651-880a-9093-9c79-d6f398fe4280@pengutronix.de>
From:   Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
Message-ID: <8a93da1a-5426-843c-573d-45326878eb02@duagon.com>
Date:   Mon, 25 Jan 2021 20:06:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b50ee651-880a-9093-9c79-d6f398fe4280@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.64.14.204]
X-ClientProxiedBy: MEN-EX01.intra.men.de (192.168.1.1) To
 MEN-EX01.intra.men.de (192.168.1.1)
X-EXCLAIMER-MD-CONFIG: e4841e51-7998-49c0-ba41-8b8a0e2d8962
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Loop: 2
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

﻿
Hi Marc,

thx for your comments.


M. Sc.
Abhijeet Badurkar
Software Engineering 
Business Unit Computing Systems, duagon

duagon Germany GmbH
Neuwieder Straße 1-7
90411 Nürnberg
Deutschland
Phone		+49 911 99 33 5 - 219
www.duagon.com

duagon Germany GmbH - Geschäftsführer: Dr. Michael Goldbach - Mathias Kamolz - Kalina Scott - Handelsregister/Trade Register AG Nürnberg HRB 5540

This message and/or attachments may be privileged or confidential. If you are not the intended recipient, you are hereby notified that you have received this transmittal in error; any review, dissemination, or copying is strictly prohibited. If you received this transmittal in error, please notify us immediately by reply and immediately delete this message and all its attachments. Thank you.
On 25.01.21 12:43, Marc Kleine-Budde wrote:
> * PGP Signed by an unknown key
> 
> On 1/25/21 12:01 PM, Vincent MAILHOL wrote:
>>>>> +/* CTL/BTR Register Bits */
>>>>> +#define MEN_Z192_CTL0_INITRQ           BIT(0)
>>>>> +#define MEN_Z192_CTL0_SLPRQ            BIT(1)
>>>>> +#define MEN_Z192_CTL1_INITAK           BIT(8)
>>>>> +#define MEN_Z192_CTL1_SLPAK            BIT(9)
>>>>> +#define MEN_Z192_CTL1_LISTEN           BIT(12)
>>>>> +#define MEN_Z192_CTL1_LOOPB            BIT(13)
>>>>> +#define MEN_Z192_CTL1_CANE             BIT(15)
>>>>> +#define MEN_Z192_BTR0_BRP              GENMASK(21, 16)
>>>>> +#define MEN_Z192_BTR0_SJW              GENMASK(23, 22)
>>>>> +#define MEN_Z192_BTR1_TSEG1            GENMASK(27, 24)
>>>>> +#define MEN_Z192_BTR1_TSEG2            GENMASK(30, 28)
>>>>> +#define MEN_Z192_BTR1_SAMP             BIT(31)
>>>>
>>>> Please use only one space between the #define and the value.
>>> I had tried that before, but that makes the code difficult to read. The other drivers in mainline have also used more than one space.
>>
>> When I sent my first patch, I received the same comment asking me
>> to remove extra spaces. I am not here to argue which one is the
>> most readable. I just recommend you to do as such because it is
>> the prefered style here.
> 
> IMHO one space only pays out, once you add something to the driver, which
> doesn't fit into the current indention level.
ok
> 
> [...]
> 
>>>>> +struct men_z192_cf_buf {
>>>>> +       u32 can_id;
>>>>> +       u32 data[2];
>>>>
>>>> Is it possible to make it u8 data[CAN_MAX_DLEN]?
>>> The core has two 32-bit registers for data, therefore array of two 32-bit
>>> elements has been used.
>>
>> First thing, u32 is wrong, it should be either __le32 or __be32
>> to make your code portable.
> 
> You should describe the memory/packet/etc... layout of the hardware here, so if
> it's organized in 32 bit values, use them here.
> 
> If you have to use __le32, __be32 or u32 depends on how the HW is connected to
> your linux box. If it's USB you have to use the le or be variants.
> 
> For memory mapped IO with readl/writel and friend, according to:
> 
>> https://elixir.bootlin.com/linux/latest/source/include/asm-generic/io.h#L141
> 
> {read,write}{b,w,l,q}() access little endian memory and return result in native
> endianness.
> 
>> The data field of struct can_frame is an array of bytes. You have
>> to make a choice which is either casting cf->data to
>> __be32[] (what you did) or make your data field a u8[].
>>
>> If I am correct, u8[] and __be32[] has the same memory
>> layout. Thus I think it is more readable to declare it your data
>> field as a u8[] despite how it is declared on the
>> controller (and you can add a comment to reflect that).
> 
> See above, that should describe your controller.
> 
> [...]
> 
>>>>> +static int men_z192_xmit(struct sk_buff *skb, struct net_device *ndev)
>>>>> +{
>>>>> +       struct can_frame *cf = (struct can_frame *)skb->data;
>>>>> +       struct men_z192 *priv = netdev_priv(ndev);
>>>>> +       struct men_z192_regs __iomem *regs = priv->regs;
>>>>> +       struct men_z192_cf_buf __iomem *cf_buf;
>>>>> +       int status;
>>>>> +       u32 id;
>>>>> +       u16 id_11_bits;
>>>>> +       u32 id_18_bits;
>>>>> +
>>>>> +       if (can_dropped_invalid_skb(ndev, skb))
>>>>> +               return NETDEV_TX_OK;
>>>>> +
>>>>> +       status = readl(&regs->rx_tx_sts);
>>>>> +
>>>>> +       if (FIELD_GET(MEN_Z192_TX_BUF_CNT, status) == MEN_Z192_MAX_BUF_LVL) {
>>>>> +               netif_stop_queue(ndev);
>>>>> +               netdev_err(ndev, "not enough space in TX buffer\n");
>>>>> +
>>>>> +               return NETDEV_TX_BUSY;
>>>>> +       }
>>>>
>>>> Could you stop the queue in advance to prevent returning NETDEV_TX_BUSY?
>>> sorry, didn'get you. You mean before checking buffer count for max level? The queue is to be stopped when there are no transmission buffers left in the hardawre, right?
>>> And since now buffer is full, means NETDEV_TX_BUSY?
>>
>> Please refer to: https://www.kernel.org/doc/html/latest//networking/driver.html
> 
> In short:
> Once your TX-buffer is full, call netif_stop_queue(). This stops the stack to
> call your xmit function. Onc you've successfully send a CAN frame, call
> netif_start_queue().
> 
> Have a look at the mcp251xfd driver, how to implement that race-free. You can
> check if xmit is called with full buffer as a safety net and reutrn TX_BUSY, but
> if that happens your driver is racy.
ok, will look into this
> 
>>>>> +
>>>>> +       cf_buf = priv->dev_base + MEN_Z192_TX_BUF_START;
>>>>> +
>>>>> +       if (cf->can_id & CAN_EFF_FLAG) {
>>>>> +               /* Extended frame */
>>>>> +               id = cf->can_id & CAN_EFF_MASK;
>>>>> +               id_11_bits = FIELD_GET(MEN_Z192_CAN_ID_11_BITS, id);
>>>>> +               id_18_bits = FIELD_GET(MEN_Z192_CAN_ID_18_BITS, id);
>>>>> +
>>>>> +               id = FIELD_PREP(MEN_Z192_CFBUF_ID_11_BITS, id_11_bits) |
>>>>> +                    MEN_Z192_CFBUF_SRR |
>>>>> +                    MEN_Z192_CFBUF_IDE |
>>>>> +                    FIELD_PREP(MEN_Z192_CFBUF_ID_18_BITS, id_18_bits);
>>>>> +
>>>>> +               if (cf->can_id & CAN_RTR_FLAG)
>>>>> +                       id |= MEN_Z192_CFBUF_E_RTR;
>>>>> +       } else {
>>>>> +               /* Standard frame */
>>>>> +               id = FIELD_PREP(MEN_Z192_CFBUF_ID_11_BITS, cf->can_id);
>>>>> +
>>>>> +               if (cf->can_id & CAN_RTR_FLAG)
>>>>> +                       id |= MEN_Z192_CFBUF_S_RTR;
>>>>> +       }
>>>>> +
>>>>> +       writel(id, &cf_buf->can_id);
>>>>> +       writel(cf->can_dlc, &cf_buf->length);
>>>>> +
>>>>> +       if (!(cf->can_id & CAN_RTR_FLAG) && cf->can_dlc) {
>>>>> +               writel(be32_to_cpup((__be32 *)(cf->data)), &cf_buf->data[0]);
>>>>> +               if (cf->can_dlc > 4)
>>>>> +                       writel(be32_to_cpup((__be32 *)(cf->data + 4)),
>>>>> +                              &cf_buf->data[1]);
>>>>
>>>> Why do you cast cf->data to __be32? Shouldn't the cf_buf->data
>>>> which should be of type __be32 instead (or as commented above,
>>>> make cf_buf->data an array of bytes).
> 
> cf->data is in __be32 format. (As Vincent said above, an an u8 array for 4
> members has the same mem layout as a __be32).
> 
>>> wanted to write 4 bytes with correct byte ordering. When function
>>> be32_to_cpup is used for that purpose, it's parameter has to be of type
>>> __be32, which is why casting is done. As already said, there are two 32-bit
>>> registers for storing entire 8-byte CAN data, so it is realized with an
>>> array of 32-bit type with length of 2.
> 
>> be32_to_cpup is to convert endianness from the device to the cpu.
>>
>> As commented above, the type of your data[] is wrong.
> 
> I don't think so, as writel assumes a __le32 HW-register converted to native
> endianess.
> 
>> Also, did you test your code on a big endian architecture?
> 
> Marc
> 

-- 
Abhijeet Badurkar - Software Engineer

 
