Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA9E17C6DB
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2020 21:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFUNC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Mar 2020 15:13:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:35731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgCFUNC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Mar 2020 15:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583525581;
        bh=jP7cH0kJ6sWqinrLxiRjfTrsZY2Bw3CJMr+9cpkl1GE=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=LVeD1GG5qhe9fKWsT5iWX1/eWxw7bMQf9hGr9J+8+eyn82bdD4O9WTTMtj0G0kNqQ
         huh+juRxWUeJAzzZqQjT3En+0CPWJVvL4PNlQqQfpNqKI4zne6PaPAkZkWTNoCVC7X
         2yXP6vS/D3dO5w7ng0MSvFyocfTWhYTF8jJQxMDU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.106] ([84.176.153.207]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1jj5vb3Iot-00aILM for
 <linux-can@vger.kernel.org>; Fri, 06 Mar 2020 21:13:00 +0100
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Need help in interpreting ip status output
Message-ID: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
Date:   Fri, 6 Mar 2020 21:13:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ArRgi3C4hTw45E4p6ti6RBNqx1qSawMBUfIaD6fj75DcawY2ET
 kLPSk+4cJf36sBGtzrI3hRuISAPb4MJvDnwsg8cl2N5dkEfCR7WaWOCIgz0SsIRopDwnGPm
 TjxAH5BnXdpDRLysDpNfICV+8Z9PB3rOoy7AF7vv5CRU9nfeevu7l93gdECC+OYMRo/0pJz
 0NGDmT0wt8PDbzYDwGk7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1tJR1kUHufw=:jmxhE47ilwPvparr1rIQtM
 gGLxmK088LIse40/4nIkYritlZN0AsQCr1BFwzzyJ/XvVx1+vb6xIXYBzoZLjjELn9PEyo8IG
 VqD3ETfHEslHgmpexopQLp9SVwooaLsDWgfi4HYRih9GPaZ5mEHC/cqUbuHXgw5mEaxneznPs
 8GuWmj7LAAi5e8QoJDl78eDBzK78avWKR33BdaUW469kR11x4o6JuaCvw3pysGlYFuDPP2r0d
 70ga3rO7c2ujOVHV+H6B5pOkHnimldJJ1fi0ftt4rECMj83zpWIWSgcSBzsFgtJdjhsaGrP0l
 igH/u2F72+E3hssXqvilU50olj6RVIr6CjnMB+9HQ9QEBYGc/kCx9UT9CndywDkT7mDpl3+X5
 +K5xb5vA7Fl5wX6LyrAN30FsOthwCLHS8WF9mg3IOLSXm+Myo6sHNKXeNdktYs3NCWZE/sdqb
 iTfKXeBf42g+XRfZiXtBbiiVS4QEzlWGEBqbHXi7+la44jHVbFd5vXnm2bQHXiFO42pwK/1U+
 mREqfIkgAXTH9OhgD+K7Os+wmwQvvnNWtTdJj7VI9XTfT1CL6i+MINyuimrQSu1M1SSIs4u/g
 j1dnyvkuKh3zpTtjVCEkCcqzWjpC0IJltXihzStVPZ/1Qs49arQ5m6BdkEZsZa7uNW54Va06f
 kyHIvImhgytx31pMHoEbt81ZWiO8x+ExigLDM8YPnP3cjuDvK4uy/nj0bPVIHMI6EbKDb4sAe
 u7o4KrptaivPTfVDzUCr5cp/VWisZ/oW+6iAvUwMXABc4XNlG+0tTBhkXer6O4swamv8Gp3s/
 6dVhboB+qflot6w8TcTXWcGTpdryBHnwA9Z+GqPCTITZ0rs4QjlbIsMRxeY1GbLAcW1xk7u54
 AP66F1sWknnZtMx9pj8cQzuZfDP8m1vEdkDQaJkaasG/RqC3sGpxpFqOk7o8vtJzOUCITT6uy
 crmzjeCtHf0FQeLbjqs6RhESlYGzBhpiIGtV51REnUiCRSTXQVRxDy4JfWxBeE2ADC3CKcABe
 wr84XVyw7g0QOialG5zzhjCb8jaKO0POrHaj0rPIlQJ/xfovG5sOy0BCyh73m0P2YC12XkL6y
 WcUNsH7NkKEmv1lZLX/RDHmvozNHa96N8ONM46N4ot+IOjKYDPsAlUbDDCvMz32RO4k4wGSpe
 psCVGFDoAOXHXdpaAb6+xGqeitWOi0CWEDD2pBc8JNEEAG8hea2Tcldsbt+WzRldw5hwQbF58
 zVzfxGhgtkhriKyTr
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

can someone help me interpreting the following ip output:

ip -s link show can1
      3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT group default qlen 100
          link/can
          RX: bytes  packets  errors  dropped overrun mcast
          0          9987413  1       74      1       0
          TX: bytes  packets  errors  dropped carrier collsns
          0          0        0       0       0       0

I'm especially interested in the meaning of the

* 1 errors
* 74 dropped
* 1 overrun

fields.

Thanks and best regards,
Andr=C3=A9
