Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A9F44ECB0
	for <lists+linux-can@lfdr.de>; Fri, 12 Nov 2021 19:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhKLSnx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Nov 2021 13:43:53 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:41213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhKLSnw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Nov 2021 13:43:52 -0500
Received: from photo-meter.com ([62.157.76.134]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4Q4m-1mb38f33f4-011Tc3 for <linux-can@vger.kernel.org>; Fri, 12 Nov 2021
 19:40:59 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 41B833B08B7
        for <linux-can@vger.kernel.org>; Fri, 12 Nov 2021 19:40:24 +0100 (CET)
Message-ID: <88ddcee3-65b6-4b4e-332c-6f23ad39c35f@photo-meter.com>
Date:   Fri, 12 Nov 2021 19:38:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Reply-To: anochin@photo-meter.com
Subject: Re: can: m_can: m_can_read_fifo, can_fd_dlc2len returns sometimes
 cf->len=0
Content-Language: en-US
To:     linux-can@vger.kernel.org
References: <5215c43f-d208-4bc6-5bd3-3425bc4f107a@photo-meter.com>
 <20211112130744.gqnnkn67oxwumczq@pengutronix.de>
From:   Michael Anochin <anochin@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <20211112130744.gqnnkn67oxwumczq@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jbjMDz4VTvcnO+gmNroeV7qQy1DVTdSsP12xIe6OxVpm7JfY6Uv
 M/9sH9/mG2LNzHH6KNnVz89/we6W/GcNfQUzFXpFZjldydlht8EBr99Okk8fWAhx60IUhOR
 MpMSgknB/Y/00XxaaHAPEE0gFO2UIpBaC9Sp5ain+YMkwghQCxp4HGUiM0l3qfzcdS6mrx6
 valSCIskoJlfF3b8VdglA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:64pe9uFu5Dc=:WiXeQSGQB67R21vKicv9HR
 xonee/W3d6QUzUWNya8ofOCVB6oNTJkL6h9Qk46Q5A4rHZYho1O3VTz9uuyAD3/A2X+Yl8zkj
 fTVZPUcwxe6yEnRzxIBwjw+GsWG+SPnLXYp16y+LOvib90g1abIDYcnl2FmOu1v3N3LvPZ8tH
 oo1gYVALBMlmlylN2tIEuGrr7aFdY5Oh4Dt6aGlJEueMVh7qjvcKKubA18GVOlJV6SN+q7P1O
 SXIq4sczZLbpAs0xQ2mNaMvsFEbYIifYzdUmoKovpBlZW2lAEvxus53it3pv6sLRBg8//kZrv
 hs9y/wOuhk9K8vLylLrZ1kI262BJ4mefQ37EGsmDI+5ns1UtstCZbYucraFiOp7PH/nzApaDA
 FzpjXJfpM7wqNMQt8wLmY1BGmI+4+U9Wl9hOzLEcliVm+DVtLEgUwO9XvDoMqdrgk30FQJK32
 UJ12CTkJ7BPc2Q6WtNs0N8XLVzETepoeqs5aPHVW84UYn5UndFr9eauUfXCki5w7OWWsRKjnn
 bS2ajG7B/4aI+T8KgjTbPuwEKxwPPdWY2LbvAro7IokX7CdX1yoEs3h1EuwcBzqUxxHMlj/TG
 Dd7IqUXWCbfsIeJ6iTeVDmpysLcdFF1chnmCeI2wt/qf0qx1zkEnBLncIB/9forx4gF/WTqLl
 1fVqvVIfKcwmYjFC6sgTLMfhUDs08gqE9ovrNCGZH+H6c7qPFdEhGmnWRuKVALu0j32IMcl6e
 9EOEHj9OulrjDwDG
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

(in context of 5.15.1 Kernel)

1. I confirm the crashes with the command "cansend canX abc#" on each 
can-if, which resulting in

[ 9563.137691] tcan4x5x spi0.0 can0: FIFO write returned -22
[ 9573.577950] tcan4x5x spi4.0 can1: FIFO write returned -22
[ 9658.948552] tcan4x5x spi6.0 can2: FIFO write returned -22

2. After applying of your Path the system is spammed until death with 
messages (I have cut out the repeating):

[  755.039082] tcan4x5x spi4.0 can1: ack error
[  755.040039] tcan4x5x spi4.0 can1: ack error
[  755.040071] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
[  755.040358] tcan4x5x spi4.0 can1: ack error
[  755.040677] tcan4x5x spi4.0 can1: ack error
[  755.040709] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
[  755.040997] tcan4x5x spi4.0 can1: ack error
[  755.041029] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
[  755.041315] tcan4x5x spi4.0 can1: ack error
[  755.041347] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
[  755.041635] tcan4x5x spi4.0 can1: ack error
[  755.041667] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
[  755.041954] tcan4x5x spi4.0 can1: ack error
[  755.041986] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
[  755.042017] tcan4x5x spi4.0 can1: __skb_queue_add_sort: 
pos=0x00000000, new=0x00000000, diff=         0, queue_len=1
[  755.042288] tcan4x5x spi4.0 can1: ack error
[  755.042320] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail

......
......

[  807.210153] tcan4x5x spi4.0 can1: ack error
[  807.210185] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
[  807.210216] tcan4x5x spi4.0 can1: __skb_queue_add_sort:
...
....

[  807.212848] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
[  807.212878] tcan4x5x spi4.0 can1: __skb_queue_add_sort: 
pos=0x00000000, new=0x00000000, diff= 0, queue_len=1


	

Am 12.11.2021 um 14:07 schrieb Marc Kleine-Budde:
> On 12.11.2021 13:11:06, Michael Anochin wrote:
>> Hello,
>>
>> I use tcan4x5x over m_can driver with CANFD tcan4450 chip. Sometimes after
>> continuous communication I get in dmesg
>> tcan4x5x spi4.0 can1: FIFO read returned -22 . After that nothing works.
>>
>> I have followed this behavior up to can_fd_dlc2len and found the following:
>> 1. in m_can.c,  function m_can_read_fifo does
>>      cf->len = can_fd_dlc2len((fifo_header.dlc >> 16) & 0x0F);
>>      cf->len = 0
>>      DIV_ROUND_UP(cf->len, 4)
>>
>> 2. m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA, cf->data,
>> DIV_ROUND_UP(cf->len, 4)) returns error because val_count=0
>> 3. Following further chain with val_count=0:
>>      cdev->ops->read_fifo(cdev, addr_offset, val, val_count) ->
>> tcan4x5x_read_fifo -> regmap_bulk_read -> ret -EINVAL
>>
>> I can try to look deeper at fifo_header. Perhaps someone has the possible
>> cause of this behavior.
> 
> It seems the driver break when trying to send CAN frame with 0 length.
> First try to reproduce if 'cansend can0 abc#' breaks the driver. Then
> check if this patch helps:
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index ab4371aa4ff1..4278009c3eea 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -336,6 +336,9 @@ m_can_fifo_read(struct m_can_classdev *cdev,
>          u32 addr_offset = cdev->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE +
>                  offset;
>   
> +       if (val_count == 0)
> +               return 0;
> +
>          return cdev->ops->read_fifo(cdev, addr_offset, val, val_count);
>   }
>   
> @@ -346,6 +349,9 @@ m_can_fifo_write(struct m_can_classdev *cdev,
>          u32 addr_offset = cdev->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE +
>                  offset;
>   
> +       if (val_count == 0)
> +               return 0;
> +
>          return cdev->ops->write_fifo(cdev, addr_offset, val, val_count);
>   }
> 
> regards,
> Marc
> 
