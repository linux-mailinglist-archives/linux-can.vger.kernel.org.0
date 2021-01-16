Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1040B2F8CE6
	for <lists+linux-can@lfdr.de>; Sat, 16 Jan 2021 11:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbhAPKom (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 16 Jan 2021 05:44:42 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:9843 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPKok (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 16 Jan 2021 05:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610793704;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=FaVXHRBGeFY5sgxLov1kBNivojyCC8eFaJNOi+YpGek=;
        b=l0BBqhQBkZsEYUd7UJf+c60dNnMEFpP4QNnokjA/nAyQZr9QKGO8/rjC3plUdiBFOV
        InH+10dbKso5+rRe7JODjHumupaKjx+gudzLSbFwC5Cwwh4ndo/Nk7EiogQ26rSOVxEc
        1su4pCrBn0unyAu/w6KNtKWgCs0U74Uq6ARFeXA9xGByv9uOYw8DU77Pu/L/+lFsndkW
        QBQHq07BSzM3VWYhjE8kr3obWZeZxd+eQz7vmP7TWK/j83YK+FQdPcGOWR7z+QCmlqo+
        fe/KJ5JRXqlGTHRemdVZX/2lzfyOFw9c4Q1r1kc39/usOPEe7hiugbDToUfieOf1GxKL
        K6rg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT5L31lTtG"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0GAfgYfX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 16 Jan 2021 11:41:42 +0100 (CET)
Subject: Re: [RFC] Add new CAN FD bittiming parameters: Transmission Delay
 Compensation (TDC)
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <CAMZ6RqLtg1ynVeePLLriUw0+KLbTpPJHapTEanv1_EZYJSrK=g@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <3313e0c7-2552-1a06-9cc1-8fba3f4f2b2b@hartkopp.net>
Date:   Sat, 16 Jan 2021 11:41:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqLtg1ynVeePLLriUw0+KLbTpPJHapTEanv1_EZYJSrK=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Vincent,

I like this separate struct too.

On 16.01.21 08:02, Vincent Mailhol wrote:
> This RFC is a follow-up on the discussion started in:
> https://lore.kernel.org/linux-can/20210112130538.14912-1-mailhol.vincent@wanadoo.fr/T/#t
> 
> * Scope of this RFC *
> 
> I want to discuss 1/ which TDC values we should provide to the
> user and 2/ how to calculate those. In this RFC, I will not
> directly discuss how to actually modify the netlink ABI.
> 
> 
> * The code *
> 
> /**
>   * struct can_tdc - CAN FD Transmission Delay Compensation parameters
>   *
>   * At high bit rates, the propagation delay from the TX pin to the RX
>   * pin of the transceiver causes measurement errors and needs to be
>   * corrected.
>   *
>   * To solve this issue, ISO 11898-1 introduces in section 11.3.3
>   * "Transmitter delay compensation" a SSP (Secondary Sample Point)
>   * equal to the distance, in time quanta, from the start of the bit
>   * time to the measurement on the RX pin.
>   *
>   * This structure contains the parameters to calculate that SSP.
>   *
>   * @tdcv: Transmitter Delay Compensation Value. Distance, in time

would name it @tdc without 'v' as you already have it in your struct below.

>   *    quanta, from when the bit is sent on the TX pin to when it is
>   *    received on the RX pin of the transmitter.
>   *
>   *    0: Automatic mode (default). Use the value dynamically
>   *    measured by the controller.
>   *
>   *    Other values: manual mode. Use the fixed provided value.
>   *
>   *    N.B. when using the automatic mode, the dynamically measured
>   *    value might not be visible to the kernel.
>   *
>   * @tdco: Transmitter Delay Compensation Offset. Offset value, in time
>   *    quanta, defining the delay between the start of the bit
>   *    reception on the CANRX pin of the transceiver and the SSP such
>   *    as SSP = @tdcv + @tdco.

SSP = @tdc + @tdco.

>   *
>   * @tdcf: Transmitter Delay Compensation Filter window. Defines the

@tdcw: Transmitter Delay Compensation Window.

The value describes the window (of a filter).

>   *    minimum value for the SSP position, in time quanta. If SSP is
>   *    less than @tdcf, then no compensation delay occurs and the
>   *    normal sampling point is used instead. The feature is enabled
>   *    if and only if @tdcf is configured to a value greater than @tdco.
>   */
> struct can_tdc {
>      u16 tdc;
>      u16 tdco;
>      u16 tdcf;
> };


Currently all these kind of values are __u32:

https://elixir.bootlin.com/linux/v5.11-rc3/source/include/uapi/linux/can/netlink.h#L31

Shouldn't we stick on this pattern here?

struct can_tdc {
         __u32 tdc;
         __u32 tdco;
         __u32 tdcw;
};

> /**
>   * struct can_tdc_const - CAN hardware-dependent bit-timing constant
>   *    for TDC
>   *
>   * @tdcv_max: Transmitter Delay Compensation Value maximum value,
>   *    should be set to zero if the controller does not support
>   *    manual mode for tdcv.
>   * @tdco_max: Transmitter Delay Compensation Offset maximum value.
>   *    Should be set to zero if the controller does not support TDC.
>   * @tdcf_max: Transmitter Delay Compensation Filter window maximum
>   *    value. Should be set to zero if the controller does not
>   *    support this feature.
>   */
> struct can_tdc_const {
>      u16 tdcv_max;
>      u16 tdco_max;
>      u16 tdcf_max;
> };

Same question here with naming and __u32 data structure.

Regards,
Oliver

> 
> /* Do the bittiming calculation of the tdc parameters */
> static void can_set_tdc(const struct can_bittiming *dbt, struct can_tdc *tdc,
>              const struct can_tdc_const *tdc_const)
> {
>      /* As specified in ISO 11898-1 section 11.3.3 "Transmitter
>       * delay compensation" (TDC) is only applicable if data BRP is
>       * one or two.
>       */
>      if ((dbt->brp == 1) || (dbt->brp == 2)) {
>          memset(tdc, 0, sizeof(*tdc));
>          return;
>      }
> 
>      tdc->tdcv = 0;
>      /* Convert the sample point from tenth of a percent to time quanta */
>      tdc->tdco = min(can_bit_time(dbt) * dbt->sample_point / 100,
>              tdc_const->tdco_max);
>      tdc->tdcf = 0;
> }
> 
> 
> * Explanation on the code *
> 
> The only way to calculate tdcv is through measurement which is
> done by the controller. This parameter is only here to receive a
> fixed value that would be given by the user through the netlink
> interface.
> 
> The calculation of tdco is of my conception. I could not find any
> reference formula. My logic is to just reuse the normal sample
> point so that at the end ssp = tdcv + sp.  Another method might
> set ssp to the middle of the bit:
>    tdc->tdco = can_bit_time(dbt) / 2
> 
> My current proposal is not to use tdcf by default (leave it to
> zero) if doing bittiming calculation. Meaning that this value
> will only be used if configured by the user through the netlink
> interface. The reason for this choice are:
>    * the lack of test environment: on my hardware (the ETAS
>      ES582.1), everything works up fine to 8 Mbps just by using
>      the tdco.
>    * I could not find a good reference to calculate that value.
> Any ideas of how to calculate tdcf is welcome!
> 
> 
> * References *
> 
> This is a collection of specifications and references which I
> used while writing this RFC. I believe that all TDC use cases are
> covered in this RFC.
> 
>    - Bosch C_CAN FD8:
> https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd8/users_manual_c_can_fd8_r210_1.pdf
> 
>    - Microchip CAN FD Controller Module:
> http://ww1.microchip.com/downloads/en/DeviceDoc/MCP251XXFD-CAN-FD-Controller-Module-Family-Reference-Manual-20005678B.pdf
> 
>    - SAM E701/S70/V70/V71 Family:
> https://www.mouser.com/datasheet/2/268/60001527A-1284321.pdf
> 
>    - ISO 11898-1
> 
> 
> Thank you for your comments,
> 
> 
> Yours sincerely,
> Vincent
> 
