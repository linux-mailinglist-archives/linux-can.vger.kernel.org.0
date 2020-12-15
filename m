Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA89B2DB5A0
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 22:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgLOVKu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 16:10:50 -0500
Received: from coruscant.sevenbyte.org ([45.32.152.104]:57954 "EHLO
        coruscant.sevenbyte.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgLOVKs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 16:10:48 -0500
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Dec 2020 16:10:47 EST
Received: from [IPv6:2003:cd:370e:4d00:7d0:30c6:72d:ea04] (p200300cd370e4d0007d030c6072dea04.dip0.t-ipconnect.de [IPv6:2003:cd:370e:4d00:7d0:30c6:72d:ea04])
        (Authenticated sender: stefan@rumpelsepp.org)
        by coruscant.sevenbyte.org (Postfix) with ESMTPSA id 8ACBD3ED93;
        Tue, 15 Dec 2020 21:59:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rumpelsepp.org;
        s=dkim; t=1608065972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hqgZ1wKmenYE9CftACXOvsmBqXvdZtw3srzX4zSWw5w=;
        b=Zl+ds/4oMQsUZwAvmkX/8RVFiEHOJcxxajMxfiIiFrNDMVJb80pw9HhYcp0v28c9fD1YaP
        MJBhslid3kbNqGJx2rAUCokcgat+z/HInbd77q4eSwNNFYwPmvKCgDVKz/fNNtiQFcM2Wh
        isQLocZzFgMFdzglzqpUBz6kLZyVX2LRnps/GzYilFgkd806Z11TnzKcHP3Jpupg+vc+CK
        A736md8S74LU4ET8zMqTwor8uLZUYAzP/8mDmTxMJ41ETnoQB/lclc+eSCEgcoRBZbHDbR
        U4F/h5nUoZX9y0vGCqsHsw48UhNjK26IWJdJRET/Pzdcz4yR3K9uzdjGl3+MCl1ad88BhG
        AJG/+N2S/cXVR32KEJ7DYo5oQahhDBBng7TDy8NB4di7twxeSt4COsBElN4N4nRAJpq22W
        OBYMwaNZm/Va3tZJcYi+1SXr1FEUUTWvLD6cDLYMLInqB0eQTOXPPh9XGscaYGC9/t+WHv
        gKvgV9+lMy5vr/yyy+pZj+1SrLMqn7aHxP32T1a2760xJB1T+fIS+EHIfPoseeZaXck78r
        dVlUQjRbMzG4KmWjACayPZ+WypSY9ryA1wxOJdhx2OlQ93C8iCQPReHFghxzaKtVq8K7lS
        ZSkHKJB6BsUZ3ToFg4sn8o3zgCHixelinCB/bMpN+Fz4Hh2tuUIT8=
Message-ID: <ad68c4ebcdadb31cbf9fd78c9ad38b57ee9ef562.camel@rumpelsepp.org>
Subject: pcan: usb_submit_urb() hangs in peak_usb_ndo_start_xmit()
From:   Stefan Tatschner <stefan@rumpelsepp.org>
To:     linux-can@vger.kernel.org
Cc:     ferdinand.jarisch@aisec.fraunhofer.de,
        Tobias Specht <tobias.specht@aisec.fraunhofer.de>
Date:   Tue, 15 Dec 2020 21:59:31 +0100
Content-Type: multipart/mixed; boundary="=-ES2x4BOANGpOMcaCO9/S"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--=-ES2x4BOANGpOMcaCO9/S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi folks!

I think we spotted a problem in the pcan_usb_fd device driver. I
tracked it down but I have no idea if this is actually a device or a
driver problem. First things first. Wo do stuff with can(-fd) and iso-
tp using the pcan pro fd interface and we discovered a weird cornercase
which can be reproduced with the attached python script.

For the reproducer setup take a pcan pro fd, connect channel 1 to
channel 2 and set the device up (for both channels) like the following:

# ip link set can0 type can bitrate 500000 dbitrate 2000000 fd on
# ip link set can1 type can bitrate 500000 dbitrate 2000000 fd on

Then run isotprecv:

# isotprecv -l -d 0x650 -s 0x6f0 -L 72:64:1 can1

And start the attached poc.py script.

The very can frame which poc.py should send is:

  25 ff

But this can frame is always missing on the bus. It is missing in the
output of candump or wireshark as well. This behaviour seems to be
dependent on how many consecutive iso-tp frames are generated. In other
words, large iso-tp packets are truncated. This can not be reproduced
via the virtual vcan interface.

This cornercase unfortunately breaks our testing setups. Let's track it
down. I did a few rounds of pr_debug() debugging.

-----------------------------------------------------------------------
af_can.c

I checked if this problem originates from the isotp module by checking
the input of can_send() in af_can.c. Everything looks fine there:

[snip]
Dez 15 21:33:12 kronos kernel: 24 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  $...............
Dez 15 21:33:12 kronos kernel: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Dez 15 21:33:12 kronos kernel: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Dez 15 21:33:12 kronos kernel: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Dez 15 21:33:12 kronos kernel: can_send: calling queue xmit
Dez 15 21:33:12 kronos kernel: 25 ff                                            %.
Dez 15 21:33:12 kronos kernel: can_send: calling queue xmit

------------------------------------------------------------------------
pcan_usb_core.c

I went one layer deeper and took a look at peak_usb_ndo_start_xmit(),
especially the usb_submit_urb() call. The problem seems to be that the
very last call to usb_submit_urb() call blocks for over a minute.

Dez 15 21:33:12 kronos kernel: peak_usb_ndo_start_xmit: submitting urb
Dez 15 21:33:12 kronos kernel: peak_usb_ndo_start_xmit: urb success
Dez 15 21:33:12 kronos kernel: peak_usb_ndo_start_xmit: submitting urb
Dez 15 21:41:59 kronos kernel: peak_usb_ndo_start_xmit: urb success         <---- ??


Anybody out there who can help me tracking this down further?

Stefan

--=-ES2x4BOANGpOMcaCO9/S
Content-Disposition: attachment; filename="poc.py"
Content-Type: text/x-python3; name="poc.py"; charset="UTF-8"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoKaW1wb3J0IHNvY2tldAppbXBvcnQgc3RydWN0CmltcG9y
dCB0aW1lCgoKIyBTb2NrZXQgQ29uc3RhbnRzIG5vdCBhdmFpbGFibGUgaW4gdGhlIHNvY2tldCBt
b2R1bGUKIyBodHRwczovL2dpdGh1Yi5jb20vaGFydGtvcHAvY2FuLWlzb3RwL2Jsb2IvbWFzdGVy
L2luY2x1ZGUvdWFwaS9saW51eC9jYW4vaXNvdHAuaApTT0xfQ0FOX0lTT1RQID0gc29ja2V0LlNP
TF9DQU5fQkFTRSArIHNvY2tldC5DQU5fSVNPVFAKCiMgVmFsdWV0eXBlcyBmb3IgU09MX0NBTl9J
U09UUApDQU5fSVNPVFBfT1BUUyA9IDEKQ0FOX0lTT1RQX1JFQ1ZfRkMgPSAyCkNBTl9JU09UUF9U
WF9TVE1JTiA9IDMKQ0FOX0lTT1RQX1JYX1NUTUlOID0gNApDQU5fSVNPVFBfTExfT1BUUyA9IDUK
CiMgRmxhZ3MgZm9yIHNldHNvY2tvcHQgQ0FOX0lTT1RQX09QVFMKQ0FOX0lTT1RQX0xJU1RFTl9N
T0RFID0gMHgwMDEKQ0FOX0lTT1RQX0VYVEVORF9BRERSID0gMHgwMDIKQ0FOX0lTT1RQX1RYX1BB
RERJTkcgPSAweDAwNApDQU5fSVNPVFBfUlhfUEFERElORyA9IDB4MDA4CkNBTl9JU09UUF9DSEtf
UEFEX0xFTiA9IDB4MDEwCkNBTl9JU09UUF9DSEtfUEFEX0RBVEEgPSAweDAyMApDQU5fSVNPVFBf
SEFMRl9EVVBMRVggPSAweDA0MApDQU5fSVNPVFBfRk9SQ0VfVFhTVE1JTiA9IDB4MDgwCkNBTl9J
U09UUF9GT1JDRV9SWFNUTUlOID0gMHgxMDAKQ0FOX0lTT1RQX1JYX0VYVF9BRERSID0gMHgyMDAK
Cgpzb2NrID0gc29ja2V0LnNvY2tldChzb2NrZXQuUEZfQ0FOLCBzb2NrZXQuU09DS19ER1JBTSwg
c29ja2V0LkNBTl9JU09UUCkKc29jay5iaW5kKCgiY2FuMCIsIDB4NmYwLCAweDY1MCkpCiMgZGF0
YSA9IHN0cnVjdC5wYWNrKCJASUlCQkJCIiwgZmxhZ3MsIGZyYW1lX3R4dGltZSwgZXh0X2FkZHIs
CiMgICAgICAgICAgICAgICAgICAgIHR4cGFkX2NvbnRlbnQsIHJ4cGFkX2NvbnRlbnQsIHJ4X2V4
dF9hZGRyZXNzKQojIHNvY2suc2V0c29ja29wdChzZWxmLlNPTF9DQU5fSVNPVFAsIHNlbGYuQ0FO
X0lTT1RQX09QVFMsIGRhdGEpCmNhbm10dSA9IDcyCmRhdGEgPSBzdHJ1Y3QucGFjaygiQEJCQiIs
IGNhbm10dSwgNjQsIDApCnNvY2suc2V0c29ja29wdChTT0xfQ0FOX0lTT1RQLCBDQU5fSVNPVFBf
TExfT1BUUywgZGF0YSkKCgojIGZvciBpIGluIHJhbmdlKDB4NDApOgpzb2NrLnNlbmQoYiJceDAw
IiooMHg1MjkpK2IiXHhmZiIpCnRpbWUuc2xlZXAoMC4wNSkKc29jay5zZW5kKGIiXHgwMCIqKDB4
NTJhKStiIlx4ZmYiKQojIHRpbWUuc2xlZXAoMC4wNSkKIyBzb2NrLnNlbmQoYiJceENBXHhDQVx4
Q0FceENBIikKIyB0aW1lLnNsZWVwKDAuMDUpCg==


--=-ES2x4BOANGpOMcaCO9/S--

