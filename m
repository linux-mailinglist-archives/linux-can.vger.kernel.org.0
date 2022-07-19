Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4557A175
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiGSO2K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 19 Jul 2022 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiGSO1o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:27:44 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546AC45988
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:14:24 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 6so26667414ybc.8
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7hhFyYnVB7IfB4/2z03D94SvSP24OS/sJrQMSb5IOys=;
        b=uvaqqelsm+P+QRGWysgRlK6oQ4HmX0W7bOWt5qfWmntdfVBuyiJNJ3RSbWjNzMqzT+
         rB34uJqKGXKo8LCj0laAwOzPkPG7g7b7HmWrBAHGgcGIiWV41Hkj0rtEV9WMrOdAuoeb
         0c4Bivmq6PloMniiLNsBGsh6PmqeYzKg0vk+ircUQl4cLPj4gKrY24J+gfjGEUHBogTH
         P/7II0mkMY9D/yzyjbUwLTN9do2Vl/QPUjyJkUuhhZfcRT4AicxvRmPdZR8MKYt6W2wv
         m8+Mnrv2v6LPqPFuK1VQVWuiQITU1VZHEAzyrKLXaBPGVcjsKUjmqv6NqOsgzxEj9H+7
         XXvg==
X-Gm-Message-State: AJIora8xwP/dXk5aj6a+g1juOzPYdkTTZ2BVVKQRlt0ukOurcqOxnLHa
        TgJSOoeUQDFERrKRxgwJ5gWZ3Cdo8W1SU8U7YdZ0+Zclqow=
X-Google-Smtp-Source: AGRyM1s8HPutKA64nVnI+D1SK78zFJTvZX6ovF+lgADp/iUFxFtg+8brppmTc7zdsoz+tWVi/QunDjtpXytrSwUD9aY=
X-Received: by 2002:a25:72d4:0:b0:670:7c08:a9e8 with SMTP id
 n203-20020a2572d4000000b006707c08a9e8mr5191399ybc.423.1658240063490; Tue, 19
 Jul 2022 07:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
 <20220712153157.83847-11-mailhol.vincent@wanadoo.fr> <4341b5a443449721e9655e65f742c50684f53ffe.camel@esd.eu>
In-Reply-To: <4341b5a443449721e9655e65f742c50684f53ffe.camel@esd.eu>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 19 Jul 2022 23:14:12 +0900
Message-ID: <CAMZ6RqLgEQzsmgB1jxjWdNQZtw9w3ZkFnWoeZQ3p9eJ9kMjC1A@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] can: error: specify the values of data[5..7] of
 CAN error frames
To:     =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        Frank Jungclaus <Frank.Jungclaus@esd.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 19 Jul. 2022 at 19:50, Stefan Mätje <Stefan.Maetje@esd.eu> wrote:
> Hi Vincent,
>
> I'm a bit late to the party, but shouldn't the patch do that what you promise in
> the commit message? See at the end.
>
> Best regards,
>     Stefan
>
> Am Mittwoch, den 13.07.2022, 00:31 +0900 schrieb Vincent Mailhol:
> > Currently, data[5..7] of struct can_frame, when used as a CAN error
> > frame, are defined as being "controller specific". Device specific
> > behaviours are problematic because it prevents someone from writing
> > code which is portable between devices.
> >
> > As a matter of fact, data[5] is never used, data[6] is always used to
> > report TX error counter and data[7] is always used to report RX error
> > counter. can-utils also relies on this.
> >
> > This patch updates the comment in the uapi header to specify that
> > data[5] is reserved (and thus should not be used) and that data[6..7]
> > are used for error counters.
> >
> > Fixes: 0d66548a10cb ("[CAN]: Add PF_CAN core module")
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  include/uapi/linux/can/error.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
> > index 34633283de64..4eb7da568dde 100644
> > --- a/include/uapi/linux/can/error.h
> > +++ b/include/uapi/linux/can/error.h
> > @@ -120,6 +120,9 @@
> >  #define CAN_ERR_TRX_CANL_SHORT_TO_GND  0x70 /* 0111 0000 */
> >  #define CAN_ERR_TRX_CANL_SHORT_TO_CANH 0x80 /* 1000 0000 */
> >
> > -/* controller specific additional information / data[5..7] */
> > +/* data[5] is reserved (do not use) */
> > +
> > +/* TX error counter / data[6] */
> > +/* TX error counter / data[7] */
>
> /* RX error counter / data[7] */
>    ^

Maybe I should pay a visit to my ophthalmologist? Thank you for
spotting the typo, I will send a v2.


Yours sincerely,
Vincent Mailhol
