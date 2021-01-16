Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50FE2F8BF4
	for <lists+linux-can@lfdr.de>; Sat, 16 Jan 2021 08:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbhAPHDg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 16 Jan 2021 02:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbhAPHDg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 16 Jan 2021 02:03:36 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99984C061757
        for <linux-can@vger.kernel.org>; Fri, 15 Jan 2021 23:02:55 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d199so1161746ybc.0
        for <linux-can@vger.kernel.org>; Fri, 15 Jan 2021 23:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OU0u4KBcvD4HmDvfGmZIBG00OaS5XJeVHT+KUR1/BqQ=;
        b=skcinvSilSu2j3fcNvdCDTFEaLFSMxQEqUzs4fyP5mSV4VAinquz710BXsGXarzGVb
         vLhfdn8OhflV3iZLjLcq1JqhrvpL8CNVej4L4b8ru9/zN5WQOa118wZpsaijvc4Jp1MT
         cCkjhSLgILblnTFcSvBZ3svv32yT4rgYF8Phrr5eq6FQrnBgRUQ+GUqGzhFVON0VdxDn
         9dnooRHhIM3133Pe1lgY5/k2gej3MQSAvdf/9LtqeolYOevr1GsOReQXVu0qYOo/8PNS
         UQrsuViumituI2SVX910+Lo3GEpK9uMiVg44+DB3NTx8f2NTXXfoZCKEaU8YHhtX4quj
         sqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OU0u4KBcvD4HmDvfGmZIBG00OaS5XJeVHT+KUR1/BqQ=;
        b=qadvkFHP83M6L+uwKlXMZ6U3iXxlL/U9iMYlO/6mF9E0Tu+MlxJfsCP6BYgvgCsgcP
         wNUaXz6PruA7mhQz8GW4Tm30lHfVDKsxbMbQknyHhbrNDm77k5Jj5TMKXHuVAihANKjp
         ADHDmyvW3SW+dD5iJtZIIlc27R1Z9gXyEGDzdmXHyOnh4t91rd6nN/ZiHuJfQI8plqBt
         PJwb3CG4uciNLpK83ZbIEfZxaE1Um65g3WOvhDuAShGQ9FFYY7sdnxZlRBmKOxW7kjlr
         hmHX3Or24Fx3lSnnxlZwUGZ3M2AjViycwgsldpO3TdqUGyTJUWKrgTfcpmkW+GyNQcZM
         pdwA==
X-Gm-Message-State: AOAM533OhkJcUKUn6YE37QPZfiAo+CVWhVbsSwkzkpdxyA1MFJG7++bX
        Hdl43sq0UZs/qvflqzGHF9Om+4pcglviE5pbeOg=
X-Google-Smtp-Source: ABdhPJz1NdanHKPoHNG3vm2H0KhafXrb6WeDu0kVdf7UYhbIBdF9aBWf8OY1apiBM4e7Q4hZaaQpk/t70qRIhbxpC/U=
X-Received: by 2002:a25:5583:: with SMTP id j125mr21096543ybb.307.1610780574755;
 Fri, 15 Jan 2021 23:02:54 -0800 (PST)
MIME-Version: 1.0
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 16 Jan 2021 16:02:44 +0900
Message-ID: <CAMZ6RqLtg1ynVeePLLriUw0+KLbTpPJHapTEanv1_EZYJSrK=g@mail.gmail.com>
Subject: [RFC] Add new CAN FD bittiming parameters: Transmission Delay
 Compensation (TDC)
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This RFC is a follow-up on the discussion started in:
https://lore.kernel.org/linux-can/20210112130538.14912-1-mailhol.vincent@wanadoo.fr/T/#t

* Scope of this RFC *

I want to discuss 1/ which TDC values we should provide to the
user and 2/ how to calculate those. In this RFC, I will not
directly discuss how to actually modify the netlink ABI.


* The code *

/**
 * struct can_tdc - CAN FD Transmission Delay Compensation parameters
 *
 * At high bit rates, the propagation delay from the TX pin to the RX
 * pin of the transceiver causes measurement errors and needs to be
 * corrected.
 *
 * To solve this issue, ISO 11898-1 introduces in section 11.3.3
 * "Transmitter delay compensation" a SSP (Secondary Sample Point)
 * equal to the distance, in time quanta, from the start of the bit
 * time to the measurement on the RX pin.
 *
 * This structure contains the parameters to calculate that SSP.
 *
 * @tdcv: Transmitter Delay Compensation Value. Distance, in time
 *    quanta, from when the bit is sent on the TX pin to when it is
 *    received on the RX pin of the transmitter.
 *
 *    0: Automatic mode (default). Use the value dynamically
 *    measured by the controller.
 *
 *    Other values: manual mode. Use the fixed provided value.
 *
 *    N.B. when using the automatic mode, the dynamically measured
 *    value might not be visible to the kernel.
 *
 * @tdco: Transmitter Delay Compensation Offset. Offset value, in time
 *    quanta, defining the delay between the start of the bit
 *    reception on the CANRX pin of the transceiver and the SSP such
 *    as SSP = @tdcv + @tdco.
 *
 * @tdcf: Transmitter Delay Compensation Filter window. Defines the
 *    minimum value for the SSP position, in time quanta. If SSP is
 *    less than @tdcf, then no compensation delay occurs and the
 *    normal sampling point is used instead. The feature is enabled
 *    if and only if @tdcf is configured to a value greater than @tdco.
 */
struct can_tdc {
    u16 tdc;
    u16 tdco;
    u16 tdcf;
};


/**
 * struct can_tdc_const - CAN hardware-dependent bit-timing constant
 *    for TDC
 *
 * @tdcv_max: Transmitter Delay Compensation Value maximum value,
 *    should be set to zero if the controller does not support
 *    manual mode for tdcv.
 * @tdco_max: Transmitter Delay Compensation Offset maximum value.
 *    Should be set to zero if the controller does not support TDC.
 * @tdcf_max: Transmitter Delay Compensation Filter window maximum
 *    value. Should be set to zero if the controller does not
 *    support this feature.
 */
struct can_tdc_const {
    u16 tdcv_max;
    u16 tdco_max;
    u16 tdcf_max;
};

/* Do the bittiming calculation of the tdc parameters */
static void can_set_tdc(const struct can_bittiming *dbt, struct can_tdc *tdc,
            const struct can_tdc_const *tdc_const)
{
    /* As specified in ISO 11898-1 section 11.3.3 "Transmitter
     * delay compensation" (TDC) is only applicable if data BRP is
     * one or two.
     */
    if ((dbt->brp == 1) || (dbt->brp == 2)) {
        memset(tdc, 0, sizeof(*tdc));
        return;
    }

    tdc->tdcv = 0;
    /* Convert the sample point from tenth of a percent to time quanta */
    tdc->tdco = min(can_bit_time(dbt) * dbt->sample_point / 100,
            tdc_const->tdco_max);
    tdc->tdcf = 0;
}


* Explanation on the code *

The only way to calculate tdcv is through measurement which is
done by the controller. This parameter is only here to receive a
fixed value that would be given by the user through the netlink
interface.

The calculation of tdco is of my conception. I could not find any
reference formula. My logic is to just reuse the normal sample
point so that at the end ssp = tdcv + sp.  Another method might
set ssp to the middle of the bit:
  tdc->tdco = can_bit_time(dbt) / 2

My current proposal is not to use tdcf by default (leave it to
zero) if doing bittiming calculation. Meaning that this value
will only be used if configured by the user through the netlink
interface. The reason for this choice are:
  * the lack of test environment: on my hardware (the ETAS
    ES582.1), everything works up fine to 8 Mbps just by using
    the tdco.
  * I could not find a good reference to calculate that value.
Any ideas of how to calculate tdcf is welcome!


* References *

This is a collection of specifications and references which I
used while writing this RFC. I believe that all TDC use cases are
covered in this RFC.

  - Bosch C_CAN FD8:
https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd8/users_manual_c_can_fd8_r210_1.pdf

  - Microchip CAN FD Controller Module:
http://ww1.microchip.com/downloads/en/DeviceDoc/MCP251XXFD-CAN-FD-Controller-Module-Family-Reference-Manual-20005678B.pdf

  - SAM E701/S70/V70/V71 Family:
https://www.mouser.com/datasheet/2/268/60001527A-1284321.pdf

  - ISO 11898-1


Thank you for your comments,


Yours sincerely,
Vincent
