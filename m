Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8465E702410
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 08:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjEOGGt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 May 2023 02:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjEOGGT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2023 02:06:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5093C10;
        Sun, 14 May 2023 22:58:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64359d9c531so9145976b3a.3;
        Sun, 14 May 2023 22:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684130328; x=1686722328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8KGssz1w4DZJK1Vr5zt5uYG0JD7zKe5eeNlCKr5k0f0=;
        b=pfZXVDCKY+APnOW7TGlyyuh2Gd+ps29ElH2GkUVlknjGDamI76pt9yVK4x7f2+Xd3o
         xOgpD7s7nrvHWLooKBHNqzN52rQgzlZs2tEF24oFMx7Nl/fQQYZYMKlrnC6bwQscwHhF
         Aj/Xy6MdiWdujoxvg2nri5ry/BQcUKw8jF/82y/Xu/SJhlOZFG8oLnGxobcATw18SmaL
         JKo8IBA3Zco0dplY4SHgesKrIzViiMc9vPGijnBBO8xBVYj+i3yTZH1SQSXdXSm5d2+/
         Ear8yTtlRUhHIYBkn00vt0dXv+JBS0m8HY2nE+cKZjNaJzbt3ULpQ/QipSTUDiAotKHu
         lKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684130328; x=1686722328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KGssz1w4DZJK1Vr5zt5uYG0JD7zKe5eeNlCKr5k0f0=;
        b=LjMfaZhZZ/nLqLLqHNbNNEYK7RTRPOJh//p4FXaDzkRCvLDnCBRWt5xYsuB9COl2dg
         2VjEHtW4URHm0CiWlujuRaAHrYo782yzH7FKK245r4zQQuo0oheUqeh9lC5i5nDJT3wR
         KdVqqVlwVYnkHRgY0QYuHbpxZlghxCDJDIKY4tpFdI0IX6yA3jdHPZOF7SJI0M89Z1ws
         J1V86jFWRj+W+G1gCb56Sfn88egkUHdKJhmFf6fciNl9Pz58OzS5cwprj6xnNX9LkQ6n
         UWpfgXwuBAPPrYlzf8LJE1JbA6dUSLlroXO18Q/oqJeHAznDLBvkSzPR7qhLUZlQuNC9
         bDaw==
X-Gm-Message-State: AC+VfDwa/xj1L7vu2ZLM0I57KXI20Cfh6fpIPdgdYvv4WXfBgTjcp3vE
        PLWAvlHseyD62gJFp1m1L7CTGxqKBKh+t/b2r/w=
X-Google-Smtp-Source: ACHHUZ7Q6AqHlcirZ3/CWy+O9nweD+u1pqXIhTP/OvNRsXXL+YLKQ3y+cBLtOJHNQVOUaKBJPXGEZPRfMNfOP3PWCXg=
X-Received: by 2002:a05:6a00:2d09:b0:63b:5c82:e209 with SMTP id
 fa9-20020a056a002d0900b0063b5c82e209mr46680756pfb.10.1684130327699; Sun, 14
 May 2023 22:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <CAK8P3a1biW1qygRS8Mf0F5n8e6044+W-5v+Gnv+gh+Cyzj-Vjg@mail.gmail.com>
 <8bd1dc3b-e1f0-e7f9-bf65-8d243c65adb5@opensynergy.com> <ed2d2ea7-4a8c-4616-bca4-c78e6f260ba9@app.fastmail.com>
 <CAMZ6Rq+RjOHaGx-7GLsj-PNAcHd=nGd=JERddqw4FWbNN3sAXA@mail.gmail.com> <9bdba1e2-9d1f-72b3-8793-24851c11e953@opensynergy.com>
In-Reply-To: <9bdba1e2-9d1f-72b3-8793-24851c11e953@opensynergy.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Mon, 15 May 2023 14:58:36 +0900
Message-ID: <CAMZ6RqKfdBio3cnH+FpeCwasoVNBZ3x55FiM+BpgrurKkT8aHg@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH 1/1] can: virtio: Initial virtio CAN driver.
To:     Harald Mommer <harald.mommer@opensynergy.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        Harald Mommer <hmo@opensynergy.com>,
        virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Stratos Mailing List <stratos-dev@op-lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Harald,

On Fri. 12 May 2023 at 22:19, Harald Mommer
<harald.mommer@opensynergy.com> wrote:
> Hello Vincent,
>
> searched for the old E-Mail, this was one of that which slipped through.
> Too much of those.
>
> On 05.11.22 10:21, Vincent Mailhol wrote:
> > On Fry. 4 nov. 2022 at 20:13, Arnd Bergmann <arnd@kernel.org> wrote:
> >> On Thu, Nov 3, 2022, at 13:26, Harald Mommer wrote:
> >>> On 25.08.22 20:21, Arnd Bergmann wrote:
> >> ...
> >>> The messages are not necessarily processed in sequence by the CAN stack.
> >>> CAN is priority based. The lower the CAN ID the higher the priority. So
> >>> a message with CAN ID 0x100 can surpass a message with ID 0x123 if the
> >>> hardware is not just simple basic CAN controller using a single TX
> >>> mailbox with a FIFO queue on top of it.
> > Really? I acknowledge that it is priority based *on the bus*, i.e. if
> > two devices A and B on the same bus try to send CAN ID 0x100 and 0x123
> > at the same time, then device A will win the CAN arbitration.
> > However, I am not aware of any devices which reorder their own stack
> > according to the CAN IDs. If I first send CAN ID 0x123 and then ID
> > 0x100 on the device stack, 0x123 would still go out first, right?
>
> The CAN hardware may be a basic CAN hardware: Single mailbox only with a
> TX FIFO on top of this.
>
> No reordering takes place, the CAN hardware will try to arbitrate the
> CAN bus with a low priority CAN message (big CAN ID) while some high
> priority CAN message (small CAN ID) is waiting in the FIFO. This is
> called "internal priority inversion", a property of basic CAN hardware.
> A basic CAN hardware does exactly what you describe.
>
> Should be the FIFO in software it's a bad idea to try to improve this
> doing some software sorting, the processing time needed is likely to
> make things even worse. Therefore no software does this or at least it's
> not recommended to do this.
>
> But the hardware may also be a better one. No FIFO but a lot of TX
> mailboxes. A full CAN hardware tries to arbitrate the bus using the
> highest priority waiting CAN message considering all hardware TX
> mailboxes. Such a better (full CAN) hardware does not cause "internal
> priority inversion" but tries to arbitrate the bus in the correct order
> given by the message IDs.
>
> We don't know about the actually used CAN hardware and how it's used on
> this level we are with our virtio can device. We are using SocketCAN, no
> information about the properties of the underlying hardware is provided
> at some API. May be basic CAN using a FIFO and a single TX mailbox or
> full CAN using a lot of TX mailboxes in parallel.
>
> On the bus it's guaranteed always that the sender with the lowest CAN ID
> winds regardless which hardware is used, the only difference is whether
> we have "internal priority inversion" or not.
>
> If I look at the CAN stack = Software + hardware (and not only software)
> it's correct: The hardware device may re-order if it's a better (full
> CAN) one and thus the actual sending on the bus is not done in the same
> sequence as the messages were provided internally (e.g. at some socket).

OK. Thanks for the clarification.

So, you are using scatterlist to be able to interface with the
different CAN mailboxes. But then, it means that all the heuristics to
manage those mailboxes are done in the virtio host.

Did you consider exposing the number of supported mailboxes as a
configuration parameter and let the virtio guest manage these? In
Linux, it is supported since below commit:

  commit 038709071328 ("can: dev: enable multi-queue for SocketCAN devices")
  Link: https://git.kernel.org/torvalds/c/038709071328

Generally, from a design perspective, isn't it better to make the
virtio host as dumb as possible and let the host do the management?
