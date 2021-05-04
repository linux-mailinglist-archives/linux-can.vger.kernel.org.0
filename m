Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F443372A00
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhEDMXn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:23:43 -0400
Received: from mail-yb1-f173.google.com ([209.85.219.173]:33492 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEDMXn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:23:43 -0400
Received: by mail-yb1-f173.google.com with SMTP id 15so11917376ybc.0
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 05:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWaXJsG7Bqt7grvjWAl/spAmjfIrDM2A23v6fufi37k=;
        b=ZHGekjIwrLQrFfCqTugoq6+A2Uh/wN8LYK965RPfnyFYqyxWDdAxCYYHjnixEgtVrI
         OgaCXPNOJBXhv7+Rac4d3mpfJOdqnqRr8iwv3d/Vq0K7/e1uZjyfNfnQ8Vkg1c9LGZKl
         m34TJSZP6/3JdPhRxAe9nLYXta1UgTJzhLJRwbTxDcZj2g1UTqsRFgvpBeQx2TlaEb5N
         3opZlwWwHAK0RwbX83VDpAgwugB5seBp+vBSgXngpAC6qF1vekvJP02uAz7kunHq7Z7y
         aOu6llwTlH7E8JMp5dcuSCrVdx32+q3xG6dyvgOixx7F3V/dNCq4OcGdyoQXZaioWms0
         hgUg==
X-Gm-Message-State: AOAM533MEJg8lH8qhf1n7EjTBX0kRTnnlTKoxZEZzIFps7KkKPMzv1dS
        o2hE+meY2Hle4BP9jNOEqjp71GWLqhbszl3fCkuz0r9WVx0=
X-Google-Smtp-Source: ABdhPJwFe+UvzpfEp6v9zF2HFfZS3JvRaLymy4I79bdTA9xFMD4DYP0vTeVh/rHAgvx2nfaxk25titMac8w8s6FcAUI=
X-Received: by 2002:a5b:707:: with SMTP id g7mr3822044ybq.125.1620130967739;
 Tue, 04 May 2021 05:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de> <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
 <DBBPR03MB70828377F51A1747B4E9E6529D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <20210503154749.q3nrfjveixsqp3uj@pengutronix.de> <DBBPR03MB7082F029173018680E5D869C9D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <CAMZ6RqJ0t91e-e9LwzaLWTY6G9MY7mosos9-DEs=pc0mWRf86Q@mail.gmail.com> <20210504074834.tki7gzr6wz2le6o3@pengutronix.de>
In-Reply-To: <20210504074834.tki7gzr6wz2le6o3@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 4 May 2021 21:22:35 +0900
Message-ID: <CAMZ6RqK1ZnygjiZ=sXf7zBSodhL1oS1GZz1rcu=92aQ_A-sFew@mail.gmail.com>
Subject: Re: mcp251xfd receiving non ACKed frames (was: Re: More flags for logging)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Ayoub Kaanich <kayoub5@live.com>,
        linux-can <linux-can@vger.kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

Thanks for the detailed answer!

On Mar. 4 Mai 2021 at 16:48, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04.05.2021 06:46:17, Vincent MAILHOL wrote:
> > > And even on the mcp251xfd, where I receive the CAN frame, there's no way
> > > to tell if this frame has been acked or not.
>
> The test setup is:
>
>                     flexcan (listen only)
>                              |
>                              |
>    PEAK PCAN-USB FD ---------+--------- mcp2518fd (listen only)
>         (sender)             |
>                              |
>                candlelight (going to be unplugged)
>
> pcan-usb: sending CAN frames
> flexcan: receiving CAN frames - but controller in listen only mode
> mcp2518fd: receiving CAN frames - but controller in listen only mode
> candlelight: receiving CAN frames - first attached, then detached
>
> > The mcp251xfd behavior is interesting. Do you also receive the ACK
> > error flag?
>
> In my tests from yesterday neither the flexcan nor the mcp2518fd had bus
> error reporting enabled. So I haven't noticed any ACK errors on the
> mcp2518fd nor the flexcan.
>
> I just repeated the test with bus error reporting enabled:
>
> On the flexcan I receive _only_ these errors (repeating) with
> candlelight detached:
>
> | (2021-05-04 09:00:30.407709)        can0  RX - -  20000088   [8]  00 00 08 00 00 00 00 00   ERRORFRAME
> |        protocol-violation{{tx-dominant-bit-error}{}}
> |        bus-error
>
>
> On the mcp2518fd I see these errors:
>
> | (2021-05-04 09:05:00.594321)  mcp251xfd0  RX - -  222   [8]  4A 00 00 00 00 00 00 00
> | (2021-05-04 09:05:01.094418)  mcp251xfd0  RX - -  222   [8]  4B 00 00 00 00 00 00 00
> | (2021-05-04 09:05:01.594577)  mcp251xfd0  RX - -  222   [8]  4C 00 00 00 00 00 00 00
> ...unplug candlelight here...
> | (2021-05-04 09:05:02.094878)  mcp251xfd0  RX - -  20000088   [8]  00 00 02 00 00 00 00 00   ERRORFRAME
> |        protocol-violation{{frame-format-error}{}}
> |        bus-error
> | (2021-05-04 09:05:02.095589)  mcp251xfd0  RX - -  20000088   [8]  00 00 02 00 00 00 00 00   ERRORFRAME
> |        protocol-violation{{frame-format-error}{}}
> |        bus-error
> | (2021-05-04 09:05:02.096263)  mcp251xfd0  RX - -  20000088   [8]  00 00 02 00 00 00 00 00   ERRORFRAME
> |        protocol-violation{{frame-format-error}{}}
> |        bus-error
> | (2021-05-04 09:05:02.096934)  mcp251xfd0  RX - -  20000088   [8]  00 00 02 00 00 00 00 00   ERRORFRAME
> |        protocol-violation{{frame-format-error}{}}
> |        bus-error
> | (2021-05-04 09:05:02.097596)  mcp251xfd0  RX - -  20000088   [8]  00 00 02 00 00 00 00 00   ERRORFRAME
> |        protocol-violation{{frame-format-error}{}}
> |        bus-error
> | (2021-05-04 09:05:02.098261)  mcp251xfd0  RX - -  20000088   [8]  00 00 02 00 00 00 00 00   ERRORFRAME
> |        protocol-violation{{frame-format-error}{}}
> |        bus-error
> | (2021-05-04 09:05:02.099035)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00 00 00 00
> | (2021-05-04 09:05:02.099054)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00 00 00 00
> | (2021-05-04 09:05:02.099603)  mcp251xfd0  RX - -  20000088   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> |        protocol-violation{{}{}}
> |        bus-error
>
> from here now only RX frames, no error frames

I guess that above error flags are the consequence of the
interferences on the bus while unplugging the candlelight. Those
are probably not relevant to our specific topic.

> | (2021-05-04 09:05:02.100540)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00 00 00 00
> | (2021-05-04 09:05:02.100570)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00 00 00 00
> | (2021-05-04 09:05:02.100583)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00 00 00 00
> | (2021-05-04 09:05:02.100593)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00 00 00 00
> | (2021-05-04 09:05:02.101326)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00 00 00 00
>
> ... and repeating.
>
>
> Here a short dump of the mcp2518fd registers:
>
> | INT: intf(0x01c)=0xbf1a0806
> |                 IE      IF      IE & IF
> |         IVMI    x                       Invalid Message Interrupt
> |         WAKI                            Bus Wake Up Interrupt
> |         CERRI   x                       CAN Bus Error Interrupt
> |         SERRI   x                       System Error Interrupt
> |         RXOVI   x       x       x       Receive FIFO Overflow Interrupt
> |         TXATI   x                       Transmit Attempt Interrupt
> |         SPICRCI x                       SPI CRC Error Interrupt
> |         ECCI    x                       ECC Error Interrupt
> |         TEFI    x                       Transmit Event FIFO Interrupt
> |         MODI    x                       Mode Change Interrupt
> |         TBCI            x               Time Base Counter Interrupt
> |         RXI     x       x       x       Receive FIFO Interrupt
> |         TXI                             Transmit FIFO Interrupt
>
> Note: there is no invalid message interrupt pending
>
> | TREC: trec(0x034)=0x00000000
> |             TXBO                Transmitter in Bus Off State
> |             TXBP                Transmitter in Error Passive State
> |             RXBP                Receiver in Error Passive State
> |           TXWARN                Transmitter in Error Warning State
> |           RXWARN                Receiver in Error Warning State
> |            EWARN                Transmitter or Receiver is in Error Warning State
> |              TEC =   0          Transmit Error Counter
> |              REC =   0          Receive Error Counter
> |
> | BDIAG0: bdiag0(0x038)=0x00000010
> |         DTERRCNT =   0          Data Bit Rate Transmit Error Counter
> |         DRERRCNT =   0          Data Bit Rate Receive Error Counter
> |         NTERRCNT =   0          Nominal Bit Rate Transmit Error Counter
> |         NRERRCNT =  16          Nominal Bit Rate Receive Error Counter
> |
> | BDIAG1: bdiag1(0x03c)=0x0000dd4b
> |            DLCMM                DLC Mismatch
> |              ESI                ESI flag of a received CAN FD message was set
> |          DCRCERR                Data CRC Error
> |         DSTUFERR                Data Bit Stuffing Error
> |         DFORMERR                Data Format Error
> |         DBIT1ERR                Data BIT1 Error
> |         DBIT0ERR                Data BIT0 Error
> |          TXBOERR                Device went to bus-off (and auto-recovered)
> |          NCRCERR                CRC Error
> |         NSTUFERR                Bit Stuffing Error
> |         NFORMERR                Format Error
> |          NACKERR                Transmitted message was not acknowledged
> |         NBIT1ERR                Bit1 Error
> |         NBIT0ERR                Bit0 Error
> |         EFMSGCNT = 56651                Error Free Message Counter
>
> > Does the controller retry to send the frame until it gets
> > acknowledged?
>
> Yes - as it should.

I should have been more careful when reading your previous
message. I could have seen that you sent the message with an
increasing payload and that as soon as the acknowledging node was
removed, the same payload kept repeating again and again.

In light of above information I have two remarks:

First, the Peak does not generate the ACK error flag as it is
expected to do. I do not know if this is a side effect of setting
it to listen only. I would expect the listen only mode to only
impact the reception, but maybe it has the side effect of also
allowing to not generate an error if not receiving the ACK bit?
Does the Peak correctly send the ACK error flag when sending in
normal mode (not listen only)?

Second, the receiver behaviour when receiving an non-ACKed frame
is actually unspecified. As mentioned before, non-ACKed frames
should be immediately followed by an ACK error flag. Here, the
receiving nodes are facing a situation which should never
occur. The mcp2518fd decides to register the frame as received
and the flexcan decides to not register the frame. I think that
both behaviors are actually fine: with the lack of specification,
the implementation is free to decide how to handle this side
case.

In short, the real question is the first point: why didn't the
Peak send the ACK error flag?

> > Are you still able to send frames and receive the echo if there is a
> > single node on the network?
>
> No - But the peak driver/hw has some limitations:
>
> The peak driver doesn't have TX complete signaling, it send the echo
> after sending the TX CAN frame via USB. And the peak controller seems to
> buffer quite a lot TX CAN frames, so it looks for the first ~72 frames
> like the bus is still working.

Yes, I also noticed that when I had peak devices in my test
lab. The peak driver call can_put_echo_skb() inside
peak_usb_ndo_start_xmit() and thus, the echo frames do not
reflect whether the actual completion occured or not. I guess
fixing that should not be too hard but I do not have access to
that hardware anymore to do it myself.

I am just surprised by the value of 72 frames. My understanding
is that peak_usb_ndo_start_xmit() should stop the network queue
whenever the number of active tx urbs reaches 10.
Ref:
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/peak_usb/pcan_usb_core.c#L399
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/peak_usb/pcan_usb_core.h#L29


Yours sincerely,
Vincent
