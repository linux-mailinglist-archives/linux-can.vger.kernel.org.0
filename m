Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892366F9B23
	for <lists+linux-can@lfdr.de>; Sun,  7 May 2023 21:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEGTUK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 7 May 2023 15:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEGTUJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 7 May 2023 15:20:09 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47755421E
        for <linux-can@vger.kernel.org>; Sun,  7 May 2023 12:20:07 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D6E788277D;
        Sun,  7 May 2023 21:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683487205;
        bh=V3H5QaHXoUhpyeosYkhbVDuyG4tIpxMfOL7cqrYTx5k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ft1vOwLlA5RUahLNQLJkh05HtJ+XWqJLw2JkunKpuO5f2IUAx/93AS5RKulTmWIyE
         Hu0sJ33D/BSDia3hz02r9ok4Or0elgOlyZ3raX2LIukcYfXyHzPJb8Fw0w3saCJW2h
         IiQ5C6A7KQiNW3GDLMVZgy6ySa7iVPoGTt7wkF3gkaZ4QjsPTX6jwIYS1lhkWds0a0
         3m0fbW/MaxpTlSmFyxJAjJBmV/2sxQX8tgk3rNB0ZRgVXZq0GktjbRD/bzSGos6OrG
         XHdk9RhqdEI6Sk/pj4prXkjePl986KVEoBvpxrPJrGHDWNhHszHsR+Klv7iBZJQX1b
         AdSbWyhTceOVA==
Message-ID: <477f68d1-ee90-be54-586f-306f479f8694@denx.de>
Date:   Sun, 7 May 2023 19:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] can: mcp251xfd: Increase poll timeout
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, Fedor Ross <fedor.ross@ifm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20230505222820.126441-1-marex@denx.de>
 <CAMZ6RqKYVJP-_Qdmj3pSAft5fsQtTK5HTsfRv+LsYwa4ngKMrQ@mail.gmail.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAMZ6RqKYVJP-_Qdmj3pSAft5fsQtTK5HTsfRv+LsYwa4ngKMrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 5/7/23 17:58, Vincent Mailhol wrote:
> Hi Marek,

Hi,

> The patches should have been in reverse order:
> 
>    1st: can: mcp251xfd: Move generic macros into length.h
>    2nd: can: mcp251xfd: Increase poll timeout
> 
> so that you do not have to remove the lines just added in the previous patch.

The current order is actually deliberate to make it easy to backport 
this one patch via stable queue, since it Fixes: a bug. The 2/2 is just 
a generalization.

> On Tue. 6 May 2023 at 07:36, Marek Vasut <marex@denx.de> wrote:
>> From: Fedor Ross <fedor.ross@ifm.com>
>>
>> Make `MCP251XFD_POLL_TIMEOUT_US` timeout calculation dynamic. Use
>> maximum of 1ms (arbitrarily chosen during driver development) and
>> bit time of one full CANFD frame including bit stuffing and bus idle
>> condition sample cycles, at the current bitrate. This seems to be
>> necessary when configuring low bit rates like 10 Kbit/s for example.
>> Otherwise during polling for the CAN controller to enter
>> 'Normal CAN 2.0 mode' the timeout limit is exceeded and the
>> configuration fails with:
>>
>> $ ip link set dev can1 up type can bitrate 10000
>> [  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode CAN 2.0 Mode (6) and stays in Configuration Mode (4) (con=0x068b0760, osc=0x00000468).
>> [  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
>> [  731.938101] A link change request failed with some changes committed already. Interface can1 may have been left with an inconsistent configuration, please check.
>> RTNETLINK answers: Connection timed out
>>
>> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
>> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>

[...]

>> @@ -251,7 +252,12 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
>>                                         FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
>>                                                   con) == mode_req,
>>                                         MCP251XFD_POLL_SLEEP_US,
>> -                                      MCP251XFD_POLL_TIMEOUT_US);
>> +                                      max(MCP251XFD_POLL_TIMEOUT_US,
>> +                                          (unsigned int)(CANFD_FRAME_LEN_MAX *
>> +                                           BITS_PER_BYTE *
>> +                                           CAN_BIT_STUFFING_OVERHEAD +
> 
> The goal is to have the exact number of bits, right?

Not really, the goal is to calculate a suitable delay, for which the 
kernel has to wait for this SPI CAN controller to switch mode . That 
delay is dependent on the bit timing though.

> It seems odd to me to use a rounded value and then try to recalculate
> the exact length in bits.
> I understand that because CANFD_FRAME_OVERHEAD_EFF is a multiple of
> BITS_PER_BYTE, CANFD_FRAME_LEN_MAX happened to be the exact value.
> Regardless, that is a fluke.
> 
> I think that we should have another set of definitions for the frame
> lengths in bits. I sent a proposal here:
> 
>   https://lore.kernel.org/linux-can/20230507155506.3179711-1-mailhol.vincent@wanadoo.fr/
> 
> If you like it, you can rebase this patch on top of mine and use the
> newly defined CANFD_FRAME_LEN_MAX_BITS_STUFFING.

I think I don't have enough experience to decide one way or the other, 
so I will wait for the reviewers to suggest the course of action.
