Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CD72FAC35
	for <lists+linux-can@lfdr.de>; Mon, 18 Jan 2021 22:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390359AbhARVGu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jan 2021 16:06:50 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:21645 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388175AbhARVD3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jan 2021 16:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611003621;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=kVL9skZCv6NZ33Q3N7mNrZLckbP0QSl8klz6jjy5q9Y=;
        b=sy8xyLtSI/CUe5UWqVyFrpphJLcbObiclBhRd8YjW3MFJCKK00QCvsyiVx7T3ZEAYU
        fUc/nj7UNw4KkgXvHfpJUAOE+QOsvsi3vI3cs+8phfuJQ+XKcW6zShwwtwAGNpKnYrd/
        zdvplX19MD4uLLDZlTGxR5qRcergbtN7HamEpSMLCuExN3mx0MyePGpEGBQRXDnL0dTF
        XkwNz75m1N3DQXj7T+hv5mlluUoKeM7DrcGwQCtpj0qpYvmiOat70kgSHxyD7bQ6P4Fz
        IA8Gnzu+6AN6ZIuMtpu83uagcrVnBK/iS5/BCs8jXyC5MsNodv+4/Ed6OFokqQ8xONCx
        gDwQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGX8h6k0QL"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0IL0Ie6n
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 18 Jan 2021 22:00:18 +0100 (CET)
Subject: Re: [RFC] Add new CAN FD bittiming parameters: Transmission Delay
 Compensation (TDC)
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <CAMZ6RqLtg1ynVeePLLriUw0+KLbTpPJHapTEanv1_EZYJSrK=g@mail.gmail.com>
 <3313e0c7-2552-1a06-9cc1-8fba3f4f2b2b@hartkopp.net>
 <CAMZ6RqLZBFZNOxFSJCuqLd7A-kNyct1xktQ-PkpePK8aGvyf0w@mail.gmail.com>
 <3ed4aa3b-8506-d906-d24f-349e664a70ce@hartkopp.net>
 <CAMZ6Rq+E4tcJ9k87FosmTcCr=s3ka-92rTR7mseF6AOw2HMsEQ@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <5f1dfbc3-16df-7d2f-8f81-75fbdf0f748b@hartkopp.net>
Date:   Mon, 18 Jan 2021 22:00:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+E4tcJ9k87FosmTcCr=s3ka-92rTR7mseF6AOw2HMsEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 17.01.21 05:25, Vincent Mailhol wrote:
> On Sun. 17 Jan 2021 at 05:58, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 16.01.21 12:33, Vincent Mailhol wrote:
>>> Hello Oliver,
>>>
>>> On Sat. 16 Jan 2021 à 19:41, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>>
>>>> Hello Vincent,
>>>>
>>>> I like this separate struct too.
>>>>
>>>> On 16.01.21 08:02, Vincent Mailhol wrote:
>>>>> This RFC is a follow-up on the discussion started in:
>>>>> https://lore.kernel.org/linux-can/20210112130538.14912-1-mailhol.vincent@wanadoo.fr/T/#t
>>>>>
>>>>> * Scope of this RFC *
>>>>>
>>>>> I want to discuss 1/ which TDC values we should provide to the
>>>>> user and 2/ how to calculate those. In this RFC, I will not
>>>>> directly discuss how to actually modify the netlink ABI.
>>>>>
>>>>>
>>>>> * The code *
>>>>>
>>>>> /**
>>>>>     * struct can_tdc - CAN FD Transmission Delay Compensation parameters
>>>>>     *
>>>>>     * At high bit rates, the propagation delay from the TX pin to the RX
>>>>>     * pin of the transceiver causes measurement errors and needs to be
>>>>>     * corrected.
>>>>>     *
>>>>>     * To solve this issue, ISO 11898-1 introduces in section 11.3.3
>>>>>     * "Transmitter delay compensation" a SSP (Secondary Sample Point)
>>>>>     * equal to the distance, in time quanta, from the start of the bit
>>>>>     * time to the measurement on the RX pin.
>>>>>     *
>>>>>     * This structure contains the parameters to calculate that SSP.
>>>>>     *
>>>>>     * @tdcv: Transmitter Delay Compensation Value. Distance, in time
>>>>
>>>> would name it @tdc without 'v' as you already have it in your struct below.
>>>
>>> Both the MCP251XXFD-CAN-FD and the Microchip CAN FD Controller
>>> Module use this naming for their register.
>>>
>>> Throughout the documents, I also encountered "Transmitter Delay
>>> Value" or just "Transmitter Delay" to designate that value (but
>>> not as a register name). I do not recall seeing "Transmitter
>>> Delay Compensation" to designate the value: this nomination is
>>> rather used for the full concept (i.e. the name of the structure).
>>>
>>> I myself am not a huge fan of the tdcv but I still prefer to use
>>> it to follow the trend. If you insist to shorten it, I would
>>> prefer to use tdv for "Transmitter Delay Value".
>>>
>>> The tdc in my struct below was a typo. I meant to also name it tdcv.
>>>
>>>>>     *    quanta, from when the bit is sent on the TX pin to when it is
>>>>>     *    received on the RX pin of the transmitter.
>>>>>     *
>>>>>     *    0: Automatic mode (default). Use the value dynamically
>>>>>     *    measured by the controller.
>>>>>     *
>>>>>     *    Other values: manual mode. Use the fixed provided value.
>>>>>     *
>>>>>     *    N.B. when using the automatic mode, the dynamically measured
>>>>>     *    value might not be visible to the kernel.
>>>>>     *
>>>>>     * @tdco: Transmitter Delay Compensation Offset. Offset value, in time
>>>>>     *    quanta, defining the delay between the start of the bit
>>>>>     *    reception on the CANRX pin of the transceiver and the SSP such
>>>>>     *    as SSP = @tdcv + @tdco.
>>>>
>>>> SSP = @tdc + @tdco.
>>>>
>>>>>     *
>>>>>     * @tdcf: Transmitter Delay Compensation Filter window. Defines the
>>>>
>>>> @tdcw: Transmitter Delay Compensation Window.
>>>>
>>>> The value describes the window (of a filter).
>>>
>>> Same here, the microcontrollers which use this feature all tend to
>>> name their register tdcf. I prefer not to deviate from the existing.
>>
>> Hm, yes. I've checked your referenced CAN controller specs - and the
>> M_CAN spec does it similarly.
>>
>> Therefore we should go with your suggestion.
>>
>> But we should always check for the best naming and description in our
>> APIs. The CAN controller guys do not always find good names for their
>> features. It was a hard discussion to rename EDL (extended data length)
>> to FDF in CAN FD ;-)
> 
> I didn't know that. So at the end, you could influence the naming
> in the ISO standard. Nice!
> 
> I think that it also depends on the timing. When you had your EDL
> vs. FDF discussion, the ink on the Bosch specification was
> probably still fresh and the ISO standard was not yet finalised.
> Now, we are too late to the party to do any changes on the naming. If
> we could go back in time, I would have liked to
> rename "Transmitter Delay" into "Propagation Delay":
> https://en.wikipedia.org/wiki/Propagation_delay
> 
> At least, I rewrote the description of each field. Hope it is
> easy enough to understand for a newcomer.
> 

Yep. Good job!

>>>
>>>>>     *    minimum value for the SSP position, in time quanta. If SSP is
>>>>>     *    less than @tdcf, then no compensation delay occurs and the
>>>>>     *    normal sampling point is used instead. The feature is enabled
>>>>>     *    if and only if @tdcf is configured to a value greater than @tdco.
>>>>>     */
>>>>> struct can_tdc {
>>>>>        u16 tdc;
>>>
>>> As written above, this is a typo. I meant:
>>> u16 tdcv;
>>>
>>>>>        u16 tdco;
>>>>>        u16 tdcf;
>>>>> };
>>>>
>>>>
>>>> Currently all these kind of values are __u32:
>>>>
>>>> https://elixir.bootlin.com/linux/v5.11-rc3/source/include/uapi/linux/can/netlink.h#L31
>>>>
>>>> Shouldn't we stick on this pattern here?
>>>>
>>>> struct can_tdc {
>>>>            __u32 tdc;
>>>
>>> __u32 tdcv;
>>>
>>>>            __u32 tdco;
>>>>            __u32 tdcw;
>>>> };
>>>
>>> Based on current value: yes. I used u16 as an anticipation of the
>>> modification that will be done on the netlink interface. Once we
>>> have a dedicated kernel only bittiming structure for the kernel,
>>> we will have more freedom and could save a few bytes.
>>>
>>> Nonetheless, this is a discussion we can have when actually doing
>>> the netlink modification. For now, I am fine to use __u32.
>>>
>>>>> /**
>>>>>     * struct can_tdc_const - CAN hardware-dependent bit-timing constant
>>>>>     *    for TDC
>>>>>     *
>>>>>     * @tdcv_max: Transmitter Delay Compensation Value maximum value,
>>>>>     *    should be set to zero if the controller does not support
>>>>>     *    manual mode for tdcv.
>>>>>     * @tdco_max: Transmitter Delay Compensation Offset maximum value.
>>>>>     *    Should be set to zero if the controller does not support TDC.
>>>>>     * @tdcf_max: Transmitter Delay Compensation Filter window maximum
>>>>>     *    value. Should be set to zero if the controller does not
>>>>>     *    support this feature.
>>>>>     */
>>>>> struct can_tdc_const {
>>>>>        u16 tdcv_max;
>>>>>        u16 tdco_max;
>>>>>        u16 tdcf_max;
>>>>> };
>>>>
>>>> Same question here with naming and __u32 data structure.
>>>
>>> Ack, OK for __32 for the moment.
>>>
>>>> Regards,
>>>> Oliver
>>>>
>>>>>
>>>>> /* Do the bittiming calculation of the tdc parameters */
>>>>> static void can_set_tdc(const struct can_bittiming *dbt, struct can_tdc *tdc,
>>>>>                const struct can_tdc_const *tdc_const)> > {
>>>>>        /* As specified in ISO 11898-1 section 11.3.3 "Transmitter
>>>>>         * delay compensation" (TDC) is only applicable if data BRP is
>>>>>         * one or two.
>>>>>         */
>>>>>        if ((dbt->brp == 1) || (dbt->brp == 2)) {
>>>>>            memset(tdc, 0, sizeof(*tdc));
>>>>>            return;
>>>>>        }
>>>>>
>>>>>        tdc->tdcv = 0;
>>>>>        /* Convert the sample point from tenth of a percent to time quanta */
>>>>>        tdc->tdco = min(can_bit_time(dbt) * dbt->sample_point / 100,
>>>>>                tdc_const->tdco_max);
>>>>>        tdc->tdcf = 0;
>>>>> }
>>>>>
>>>>>
>>>>> * Explanation on the code *
>>>>>
>>>>> The only way to calculate tdcv is through measurement which is
>>>>> done by the controller. This parameter is only here to receive a
>>>>> fixed value that would be given by the user through the netlink
>>>>> interface.
>>>>>
>>>>> The calculation of tdco is of my conception. I could not find any
>>>>> reference formula. My logic is to just reuse the normal sample
>>>>> point so that at the end ssp = tdcv + sp.  Another method might
>>>>> set ssp to the middle of the bit:
>>>>>      tdc->tdco = can_bit_time(dbt) / 2
>>>>>
>>>>> My current proposal is not to use tdcf by default (leave it to
>>>>> zero) if doing bittiming calculation. Meaning that this value
>>>>> will only be used if configured by the user through the netlink
>>>>> interface. The reason for this choice are:
>>>>>      * the lack of test environment: on my hardware (the ETAS
>>>>>        ES582.1), everything works up fine to 8 Mbps just by using
>>>>>        the tdco.
>>>>>      * I could not find a good reference to calculate that value.
>>>>> Any ideas of how to calculate tdcf is welcome!
>>>>>
>>>>>
>>>>> * References *
>>>>>
>>>>> This is a collection of specifications and references which I
>>>>> used while writing this RFC. I believe that all TDC use cases are
>>>>> covered in this RFC.
>>>>>
>>>>>      - Bosch C_CAN FD8:
>>>>> https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd8/users_manual_c_can_fd8_r210_1.pdf
>>>>>
>>>>>      - Microchip CAN FD Controller Module:
>>>>> http://ww1.microchip.com/downloads/en/DeviceDoc/MCP251XXFD-CAN-FD-Controller-Module-Family-Reference-Manual-20005678B.pdf
>>>>>
>>>>>      - SAM E701/S70/V70/V71 Family:
>>>>> https://www.mouser.com/datasheet/2/268/60001527A-1284321.pdf
>>>>>
>>>>>      - ISO 11898-1
>>>>>
>>>>>
>>>>> Thank you for your comments,
>>>>>
>>>>>
>>>>> Yours sincerely,
>>>>> Vincent
>>>>>
