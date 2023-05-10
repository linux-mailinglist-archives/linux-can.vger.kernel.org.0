Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EBE6FDC81
	for <lists+linux-can@lfdr.de>; Wed, 10 May 2023 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbjEJLTy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 May 2023 07:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjEJLTx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2023 07:19:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4228FC2
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 04:19:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab0c697c2bso66419835ad.1
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683717590; x=1686309590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVaS0GT/88PLUjO4LjZ3M+VIn7zd+R5lvnWLSCMBLz4=;
        b=p1/x46VcAAnWznNHhX2sZb4RsPgoLbVFe7DQmESmPSPsJg9Qjdd6+/d4Zvj9sc3ZN3
         U4ktsA4oH5y/74dQNcPmfLIPLEnfGdpa8F1dM15GsJb83nEn/HWOFenmZgRRMZYosX+0
         grFU4oJYhC5EdBWk1GHLQ3wxO/BdMWvah7R+KyTWGVvyFa/So8wW4+tpI4TnF8RR1TLD
         ghDFdeeFbiiA/tIg0BHzriXDaENia0XOMWq826xOvxH2Ot8kr9xGJYqM/mHNs3ubgIjt
         dD7xuvL+ZISOTeULhRyq4uQFW5EHNkX2eGtMiAh9MZUdEUiRUDEFhJSFJKH5fHwMCJK2
         ZHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683717590; x=1686309590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVaS0GT/88PLUjO4LjZ3M+VIn7zd+R5lvnWLSCMBLz4=;
        b=Hb8aT9+lr/tnXcSVezbqMnaHSWcxHdkOFZFdRqpyje2SKCaFZoSgPhUdJ9qL3sYC5b
         T5mZzHSPgUJNfwydyHiBwScAZweWvGnIAxmmUDMg4dcOcD4itJ01eex65vX3y/Lfm/6a
         o2jWzcox08Ac5KGDIZ5vIJPP5TdYPxLw5crSkHq6ah5Ips39d/e1/Ocb4oGZ4fv86UKk
         4sCAF28nF3ryasRxK5u78bfDALxXtnqOW0fzkzqGotlORVE8HakCsFf4E4sHga3nmmy9
         c4R5VC4AuzTMXVx+7ZAMxk4QmUrga6GuJrewTo9Wf9V9N1BNNGRnsiUANDQbZBZrRcNO
         Lhtw==
X-Gm-Message-State: AC+VfDzyvvb+w45xX83ifxPZWsiinH68W9iluuz2lSNePiVzyHuoCWA2
        /XISBcuqcIHvWYT8chTFpDnxgOP0bQqlWO1qQ3g=
X-Google-Smtp-Source: ACHHUZ4rnczbDlr2XBYzzYIJCfNfrFFtm2+5lI60sxOp/qox9A6zRG9roTi/F7Q3pq14LjNgeSUCXp/01Q6WQSDsFZ4=
X-Received: by 2002:a17:902:8691:b0:19a:9890:eac6 with SMTP id
 g17-20020a170902869100b0019a9890eac6mr16710038plo.24.1683717589612; Wed, 10
 May 2023 04:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230504195059.4706-1-marex@denx.de> <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
 <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <BL3PR11MB6484A68C2B2CFFAA44AD3E09FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJo=j7wsfOPsYRn++vMSnhKBuQAwckZ-u7qwjBdsb_d_g@mail.gmail.com>
 <BL3PR11MB64843D32844A848AAC7BFDF1FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqK266c+taxgUqd_2kSfbNDgTawkcthTaM+4JXpeLV0cfQ@mail.gmail.com> <BL3PR11MB64846AD5ACBC42C74D11DF7DFB779@BL3PR11MB6484.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB64846AD5ACBC42C74D11DF7DFB779@BL3PR11MB6484.namprd11.prod.outlook.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 10 May 2023 20:19:38 +0900
Message-ID: <CAMZ6Rq+M+nyxq2YaOVmVngTVZbAUHd4+YJUasvwyAkxiZJmxGw@mail.gmail.com>
Subject: Re: RE: [PATCH] can: mcp251xfd: Increase poll timeout
To:     Thomas.Kopp@microchip.com
Cc:     mkl@pengutronix.de, marex@denx.de, linux-can@vger.kernel.org,
        fedor.ross@ifm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, lgirdwood@gmail.com, mani@kernel.org,
        broonie@kernel.org, pabeni@redhat.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 10 May 2023 at 19:39, <Thomas.Kopp@microchip.com> wrote:
> > > > > Re-reading the spec again I noticed that the part where I wrote
> > > > > that there's an "idle condition" after the intermission is
> > > > > wrong. What follows the intermission is just "bus idle",
> > > > > defined two paragraphs later as "The period of bus idle may be
> > > > > of arbitrary length." The 11 recessive bits can be removed from
> > > > > the formula again. The longest period (under the assumption
> > > > > there aren't multiple/continuous errors on the bus) will be
> > > > > Frame + Error Frame (12 bit) + 2 x Overload Frame.
> > > >           ^^^^^^^^^^^^^^^^^^^^
> > > >
> > > > How did you find that a error frame is 12 bits? From section 10.4.4
> > > > "Specification of EF", I can read:
> > > >
> > > >   The EF shall consist of two different fields. The first field
> > > >   shall be given by the superposition of error flags contributed
> > > >   from different nodes. The second field shall be the error
> > > >   delimiter.
> > > >
> > > > Then:
> > > >
> > > >   Two forms of error flag may be used, the active error flag and
> > > >   the passive error flag, where
> > > >
> > > >    - the active error flag shall consist of 6 consecutive
> > > >      dominant bits, and
> > > >
> > > >    - the passive error flag shall consist of 6 consecutive
> > > >      recessive bits unless it is overwritten by dominant bits
> > > >      from other nodes.
> > > >
> > > > Finally:
> > > >
> > > >   The error delimiter shall consist of 8 recessive bits.
> > > >
> > > > So the error frame should be 14 bits (6 + 8), not 12, right?
> > > That was imprecise, you're right - I meant an Error Flag, not Frame a=
nd hence
> > the 8 recessive bits were missing. There's an active error flag + passi=
ve error
> > flag though which can be 6 bits long each. In section 10.4.4.2 The tota=
l length
> > of this sequence may vary between a minimum of 6 bit and a maximum of 1=
2
> > bit.
> >
> > The active error flag and the passive error flag may both occur, but
> > in that case, they occur as a superposition (c.f. above quotation).
> > This also means that the passive error flag is seen if and only if all
> > the nodes send a passive error flag. As long as one node sends an
> > active error flag, the superposition will hide any other passive error
> > flag.
> >
> > So, I think that the error flag is always 6.

Actually, you were right on the total but not on the reasoning (active
error flag + passive error flag 6 bits long each). The error flags are
actually between 6 and 12 bits but not because of consecutive active
and passive error flags. Even if the field is a superposition of error
flags, the nodes do not necessarily start to transmit their error flag
simultaneously on the same bit. The worst case is when node A sends an
error flag, then node B detects the error condition on the last bit of
A's error flag (bit #6). In that case, B starts to transmit his error
flag after A's error flag is completed (bit #7) and B finishes sending
its error frame on bit #12, thus the total of 6 + 6 =3D 12. But these
may very well be all dominant bits!

> I think if one node detects a bit error (that's not on the bus but inside=
 the receiving node) on the second bit of the intermission it will start se=
nding the 6 dominant bits, starting on the third bit of the intermission. N=
ow, according to 10.4.2.2 " A node sampling a dominant bit during its suspe=
nd transmission time or at the third bit of intermission shall accept it as=
 SOF.", treating the next 5 dominant bits as part of the ID of a new DF and=
 only then sending its own error flag, giving a total of 12 dominant bits f=
ollowed by 8 recessive bits EF delimiter etc. Am I missing something here? =
For this (I believe worst case when only considering 1 EF you could deduct =
one bittime - the third bit in the intermission)

If a node detects a bit error on the second bit of the intermission,
it means that it was expecting a recessive bit and measured a dominant
one. Thus, it should interpret it as the beginning of an overload
flag. Consequently, on the third bit of the intermission, that faulty
node starts to emit an overload flag and according to paragraph
10.4.5.2, all the other nodes shall also start sending an overload
flag.
In fact, we could nearly say that an overload frame is an error frame
sent during intermission. 10.4.6.2 "Intermission" clarifies this
saying that:

  During the intermission [...] only signalling of overload condition
is allowed.

The disambiguation between error and overload can be done only because
both can not coexist at the same time!

ISO 11898-1 is such a rabbit hole... sights...
