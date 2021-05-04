Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAD6372B80
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 15:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEDN71 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 09:59:27 -0400
Received: from mail-db8eur05on2081.outbound.protection.outlook.com ([40.107.20.81]:14078
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231216AbhEDN7Z (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 4 May 2021 09:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQg+1a+5UQiS7R7Z7bEnNDc4TRGb4tedp6LzbexKMJf2/mKYfqL205b0eNBsJs4x5woFDhycbGfSG+SEV8VoaH6dg9u+J2jFCUblOr1y2kBIZ2sl2AvNWiAc1Ck9ocD+J8tEEP7+mo9CpN9r/CngD85ylVTD1UuTwqTHkhPvM4HYU0ROUQKw+xtUJREelgTVnrXt+hXX1z+017fOoMw6udoKXJDHLV4fjAfaoWikY4d6TWLD3rS/3IovPO77GKLySDzyBXDZzSL+UmDFctKmccSFI/EHaibsxAuZj+pK8d06ruFFYuhkEtrKy7SruqvLAv6Jqoa4y+bgy+fJc3TeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyRWDDqVwswA1Fp3WRoHiajUUD5ew5yv6rhgQdOvd4o=;
 b=Sy6XCBVOoXtk4fp7r2U0EQxl8VrMZaREaQ0DdkKRKWLX1M1jbGU8LEWH84g9hHlBKdHDSuSAnAbAiFa2U2LZpESpjpTvsemvXj3xcCKZO+QsSVuhhY0DxH+i/+F87MqT5tQwHedajDE85QaJrJSo9Rswkdx/k0cmQuZUbRvc3u1rscrkkyul6hEv1e0fwTN53lRKsQ7p9BsO65tI3ZuG28Z35w+kejDUTEb3fYnUm34ze4QPOHhjq11KX4ITDNZo6ZtvWVNvAFSfuYnmvBB/ffl4UTwjTJ5MueL+lI3RvAa7QVycPbboc8CZ94dZlP2rZTEW7QA6oDFljYl9PiTT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technica-engineering.de; dmarc=pass action=none
 header.from=technica-engineering.de; dkim=pass
 header.d=technica-engineering.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technicaengineering.onmicrosoft.com;
 s=selector2-technicaengineering-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyRWDDqVwswA1Fp3WRoHiajUUD5ew5yv6rhgQdOvd4o=;
 b=PeHiYNqNcoQK5EqI8OEJTO+unNwaVr/Uet7YzCdWJhIKvNt1USdKvYLF7Ohs6fnQPV1mx+fMieklwd581IGJ6x78ALN2IWyznTEmHiSNhlDa9RukA/gifGFfEBIdJ5LTgDNbA93xf7cobbFjbrwW3tgxhZD1fdWZhyqhUnoptFU=
Received: from AM8PR08MB5698.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::24)
 by AM0PR08MB3748.eurprd08.prod.outlook.com (2603:10a6:208:fb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 13:58:28 +0000
Received: from AM8PR08MB5698.eurprd08.prod.outlook.com
 ([fe80::a801:b98e:ad52:c8e4]) by AM8PR08MB5698.eurprd08.prod.outlook.com
 ([fe80::a801:b98e:ad52:c8e4%6]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 13:58:28 +0000
From:   Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: More flags for logging
Thread-Topic: More flags for logging
Thread-Index: AQHXQAN6B88UeDudRkC9a0XEdYmbM6rRiGkAgAF8UICAAAJ7woAAAHPggAAAc7CAABQ4gIAAO4Uw
Date:   Tue, 4 May 2021 13:58:28 +0000
Message-ID: <AM8PR08MB5698056272C3800B6BDCAE54B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
 <641804b4-733a-57b7-fdf1-b91293207f37@hartkopp.net>
 <DBBPR03MB7082C7E8FD22D0CA8C2DA99D9D5A9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <AM8PR08MB5698886555F8531B6CF65982B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
 <AM8PR08MB5698052CEE5ABBD0B49D4A48B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
 <a0d3b5ed-b8c0-f521-911d-a0d4e039bb04@hartkopp.net>
In-Reply-To: <a0d3b5ed-b8c0-f521-911d-a0d4e039bb04@hartkopp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hartkopp.net; dkim=none (message not signed)
 header.d=none;hartkopp.net; dmarc=none action=none
 header.from=technica-engineering.de;
x-originating-ip: [62.216.206.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e30b9d8b-5260-4683-ec0e-08d90f04b1a8
x-ms-traffictypediagnostic: AM0PR08MB3748:
x-microsoft-antispam-prvs: <AM0PR08MB37484EC9FF77034F18B2CF49B75A9@AM0PR08MB3748.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1yDPy9WJYnqWRpcH1jVnGuQDk4NOyYXyLVjgoJfJ+WChQEv4a3Z/7Ig7KM6d4TLt0Vn6BFNU1eMnB66WvaUnicqIHt0MKKpns5jtwG+X57IbckCnTHbcK1UXo4gB0JOEjwGFrxvjxBx4Cd5TVzzY9tLAcrAIw/hpV3SAA0n66p2NJCvtY7hSdRuz/YkFWvyixbzgzHZGq6kmGQMOTW6fAtORRwHeLjKvVkTPttDC8Z+hT6qMmDK1SCV+pUnWUfSMo6CkFKgIclrQaJU86Gx3DAIXcVUaQF+gqQXJsZrM5vbAN95LgU8U0E/AiV9UGLPGK8efX5iCfL3pOTpmZ2VPDGbRq/fgqW5Dk/he+xKLKbI0H67xUeWi/5eKgVzkzDYJVd+X19sI5ZGPdRdj1J+Qa/ADIcAx5kECtAyWNGj8kb+j+J3PPewegAQWwpsFjmvV5zItOVQWRKob8wglEsw0uo74o0qSGBAK5UMybH2tOPjn/Qw9egc3DakwW2XJmplDwn1Qnyf3x/HRsR2v39d4Uf7m1h0iFcxsDF96fVtfPQ+aOuRLS8KJVhHLyDO//KXWiBPFN2dfzT6vORezRyvlnOw04tY0X9BTBbrNx7RMRE2zUlGWa9JyxDds9tk55kr7XINJtm2n9llzzzNWNGeZmz+ueiFSuITvxJc5PPfedeEk4DFLAL5V+YGBlG06NbfR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB5698.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(39830400003)(136003)(66946007)(71200400001)(55016002)(7696005)(44832011)(66446008)(9686003)(6506007)(966005)(26005)(53546011)(186003)(76116006)(478600001)(8676002)(2906002)(86362001)(64756008)(52536014)(5660300002)(66556008)(83380400001)(316002)(8936002)(110136005)(38100700002)(122000001)(33656002)(3480700007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?ZrVhz9cP/OgYUPL40CiJAGZr4P8IZWnVGU5rteZUKu8vhG3HSpRAee5F?=
 =?Windows-1252?Q?mC2a9dkRwaWW7Nyjaqxxc+iU6BQfzbPX6mNyiZiteFkxE3ZD9uYNX9xH?=
 =?Windows-1252?Q?wO4ZDrV1zJtPNzK7RRNUVfiYCmVAs6K+1ZVqj+NSxj/Yt2GlKIyEshwN?=
 =?Windows-1252?Q?elOtTlcdyJpd2QFEdBYIxGPGn/iDmo7Xr7ArYFahjUsjs3DPhSymtJgw?=
 =?Windows-1252?Q?w+3s2/60nyFdB1wYRMUldlAqctM/7gICpIrB8WDUx5FiQL8kQMwAwgH0?=
 =?Windows-1252?Q?Rb2IE7cQfV8oObtGEQICVTYgI1zcSnLwLlY17RcXCntK+5tE0/qD8VDd?=
 =?Windows-1252?Q?REjDNE7u3spbqqtEq5AesNTekf0930T4si5O0UHhh0Xaw5w+ElWk9AdU?=
 =?Windows-1252?Q?u3AL1t+5iOWuTT4wcgWsIkBv0KNScSUhrR/EeHnR/gcdzTwvgWu/HdFY?=
 =?Windows-1252?Q?bQrKg0Atx/DZ00ZDE6Ck68O4HhIFLiIqO/D3CB9wi3u7yAozdL4V0GgF?=
 =?Windows-1252?Q?pH4bJWa1BqZ313z5/6ioxlyvkc/iuKdVK83yk9ZtLMg5pmsezH4vZBYK?=
 =?Windows-1252?Q?/8ZNP1RDY8LwSzCeqn2KG0N2vB9iXzCMyxnSUFTmwipgCtuo18Ku32A9?=
 =?Windows-1252?Q?koryvazmmgHmVcTy4ztBz4V2+Oo6uXEsx+z/F90nb3+sYUfQMVs+W9KF?=
 =?Windows-1252?Q?KUB8hkfLd2Uq7ImQwUWnIkB2OGqWhlbkHjbtjuJ94Iw40hLLWe9tK2lt?=
 =?Windows-1252?Q?W4qi4kfrQSpFy7BH9dxRh6CTz158k99mkCPq5EbVHJWw09kWDXoJK8/0?=
 =?Windows-1252?Q?pDANA2oQeh5S3vGVfLWCCaK6XV3wMzYJ+ldr9Gen6pkhUZs2UVm+L+SB?=
 =?Windows-1252?Q?RSUbtNCaUDTcfMWDMc1UndIVJxdk7b0TczqBxd0BCf4zsSh8Nkg1A3GT?=
 =?Windows-1252?Q?Qer5o5V+kksBd1kKUOFpPXPkFLO9GqbG6tDlvQFKPAEvCKpGOh75DzWg?=
 =?Windows-1252?Q?vaZMcEroOw4sd7tcjPtK+fWFtfNNIRPqsiFeUVC1MOfVG5Wcp31k+8OQ?=
 =?Windows-1252?Q?wY7tdLodbe726YhmIRYvZ8ixckuMvkgF4fle9yeG6IcVnGaOtt8MedEk?=
 =?Windows-1252?Q?sBwglp+ALBgrgZYn7NpnXew31tpJZ8Q42aiv7rAAHTn1qkXCuMcT1XaO?=
 =?Windows-1252?Q?bmlVtQEZy2d9K/r4q7/IWZyhepNtH053EJ/WS5pj0e0IGjeZ1/dTr4Sf?=
 =?Windows-1252?Q?ZvL2DGI9T+dlyB25rVFnZdWcZR46V55slc/8wLmVqOAgOeG9zvg9WlXD?=
 =?Windows-1252?Q?hP+won78ydMhi+wU3b3i7kjlyypKmyaEmj1WkF/bYfYLzvgzGU0Vabod?=
 =?Windows-1252?Q?0KkJn7i3SOPeOZrfzQloKyp8lb7ts1aAAF6balshtx9GA+7nhbDTNpNe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5698.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30b9d8b-5260-4683-ec0e-08d90f04b1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 13:58:28.3324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e81NZWQNEEOLTwcW2HKFN8TimyiCVgtyoA5fRsUS4uAJBhxSPXQ/rbKtYwWDD/rYMACrFRD+w3vsuplOGvRgSrTWWy09/Lu1rFF2ODyUy3rVkQtit+b92N9g3UV6gfZU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3748
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

One solution is to mark a flag bit as 1/0 depending whether the frame was r=
eceived using LINUX_SLL_P_CAN or LINUX_SLL_P_CANFD.

This may solve 90% of the cases, but I don't think it's the solution we wan=
t to go with, since it does not cover classical CAN over CAN-FD transmissio=
n.
See=20
https://www.can-cia.org/fileadmin/resources/documents/proceedings/2015_espa=
rza.pdf
https://can-newsletter.org/uploads/media/raw/35a48f1d88ddf2a198638c0a5be517=
61.pdf

I believe it would be better to have an FDF bit in the SocketCAN flags, tha=
t maps to (for example) MCP251XFD_OBJ_FLAGS_FDF

Best Regards.

-----Original Message-----
From: Oliver Hartkopp <socketcan@hartkopp.net>=20
Sent: Tuesday, May 4, 2021 12:14 PM
To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>; mkl@pengutronix.=
de; linux-can@vger.kernel.org
Subject: Re: More flags for logging

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.

Hi Ayoub,

On 04.05.21 11:49, Ayoub Kaanich wrote:

> There seems to be a mis-conception about how WireShark/Libpcap handle Soc=
ketCAN:
>
> There is no ethertype involved, the data of the frame will directly start=
 with the CAN ID.
>
> The socket CAN in PCAP format pre-date CAN-FD (Developed in 2011), so at =
the time, there was only "CAN" (Introduced in Oct, 2009).
> See=20
> https://github.com/the-tcpdump-group/libpcap/commit/86ed15cc8b4bd7dc14
> 58559108e66a07ec6721ec The introduction of CAN-FD later on did not=20
> change that.

Ah, now I got the problem.

I was heavily involved in introducing CAN FD into Wireshark here:

https://github.com/wireshark/wireshark/commit/7fad354a3e379382368cd1ef67b84=
1315c29e050#diff-f0fd5f515da65110cd5c1231b43180693e1d46779765d65c997e32da11=
ae70d1

But this obviously had NO impact on libpcap :-/

> Libpcap library maps both LINUX_SLL_P_CAN and LINUX_SLL_P_CANFD (they are=
 treated identically the same way) to DLT_CAN_SOCKETCAN and copy bytes as i=
s (the only change is changing the endianness if ID if needed).

So this would mean, we need a separate handler for LINUX_SLL_P_CANFD ??

Best regards,
Oliver

>
> The MTU solution still not does provide a fix for the case of a normal CA=
N message being transported over a CAN-FD bus.
> In this case, application cannot tell if frame was physically transported=
 as CAN or CAN-FD.
> See https://noelscher.com/blog/posts/compatibility-of-can-and-can-fd/
>
> Best Regards.
>
> Ayoub Kaanich.
>
> -----Original Message-----
>
> From: mailto:socketcan@hartkopp.net
> Sent: Tuesday, May 4, 2021 10:49 AM
> To: mailto:mkl@pengutronix.de; mailto:linux-can@vger.kernel.org
> Cc: mailto:kayoub5@live.com
> Subject: Re: More flags for logging
>
>
>
> On 03.05.21 12:08, Marc Kleine-Budde wrote:
>> On 03.05.2021 12:02:46, Marc Kleine-Budde wrote:
>>> The SocketCAN API is a great initiative for standardizing the CAN=20
>>> interface API. This request tries to extend this initiative for more=20
>>> use cases.
>>>
>>> Context:
>>>
>>> The SocketCAN was adopted by libpcap and tcpdump as the standard=20
>>> format for logging CAN Frames in PCAP and PCAP-NG. See:
>>>
>>> https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html
>>> https://github.com/wireshark/wireshark/blob/master/epan/dissectors/p
>>> a cket-socketcan.c https://www.wireshark.org/docs/dfref/c/can.html
>>>
>>> Problem:
>>> Applications that perform logging, usually need more details that=20
>>> normal applications, for the sake of debugging later on. Flags needs=20
>>> to be reserved/allocated in the SocketCAN API, so that logging=20
>>> applications can make use of them in the PCAP format. The flags does=20
>>> not need necessary need to be implemented by SocketCAN, they just=20
>>> need to be marked as reserved for such use case.
>>>
>>> Needed Flags:
>>> FDF Flag
>>> - Since CAN Frames and CAN-FD frames can co-exist in the same bus,
>>>      logging application needs to know if a normal CAN Frame was
>>>      transmitted on a CAN-FD bus, namely was the FDF bit set or not.
>>
>> I think someone asked for that some time ago. But that was never=20
>> mainlined. I'll look for that old mail.
>>
>
> When you display CAN and CAN FD frames in Wireshark they are displayed as=
 different "protocols" - as they also have different ethtypes.
>
> So the difference is provided by the 'protocol' field. Or did I miss some=
thing?
>
> Regards,
> Oliver
>
>>> ACK bit in data frame
>>> - Some logging hardware can act as a "spy", meaning that it records=20
>>> CAN
>>>      Frames, but does not set the ACK bit
>>> - A way to know for a given frame (FD or not), was the ACK bit set or
>>>      not.
>>> - Current API allow detecting missing ACK, but it does not report=20
>>> what
>>>      Frame had a missing ACK.
>>
>> This means the driver has to set a flag if it's configured in=20
>> listen-only mode. That should be possible.
>>
>> I think we can make use of flags in the struct canfd_frame for this:
>>
>> | struct canfd_frame {
>> |=A0=A0=A0=A0=A0 canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags *=
/
>> |=A0=A0=A0=A0=A0 __u8    len;     /* frame payload length in byte */
>> |=A0=A0=A0=A0=A0 __u8    flags;   /* additional flags for CAN FD */
>> |=A0=A0=A0=A0=A0 __u8    __res0;  /* reserved / padding */
>> |=A0=A0=A0=A0=A0 __u8    __res1;  /* reserved / padding */
>> |=A0=A0=A0=A0=A0 __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8))=
);  };
>>
>> The struct can_frame doesn't have the flags member yet, but we can=20
>> add it there.
>>
>> regards,
>> Marc
>>
>
