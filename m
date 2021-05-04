Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57B372847
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhEDJun (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 05:50:43 -0400
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:34834
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229953AbhEDJum (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 4 May 2021 05:50:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z50zdsbHEi5aTbLKscYAh0JHn90t8AHpfCBPneuDwjvWO2/fYUIvjqaI/n4otzMEVKazoBaUCyLwSp9OW8i+t7KfE+vCT+FDosY1bHAPZ4ZDZlIDXU+vYlcrTp63BRfiBnqToCFcTiX1DjsUMk+2Z5w3txEMA2rZoIYWR6Z69aqBF6ZqSBba+VIuFLg8Mnc+VgM8yBf7C2NfG8MuD1sYJHv6WfAaP7J+Sf86FTxhXaPSTNZfTy5dRT+5+Wcxw2WvJnscB2J5Nkq/pMrI0damZwJ57K7Y/So3PoRN9EhOB+xG35As9U7mY8YUFe71iybWZ1pnFOfi3DGd8dUzn6a9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1+OOfrq2ZFkE17nOEMInFlCm9KXaqZJ723AGsTLJ64=;
 b=OZ+j4ylHDCGTD3vNpMGywbsgBZoEAwde3SoBgDZY0vr+32SPliYq4qI7S7NtGMjyjrD6hnWMmEc6O4h7MBIlyRrLH3kx58TpCWkqpYPysxD4Bt3oKJFu72hX8Yx8NonBRKVM8sZ4k9RBy5aUMRCREaQtW1Fw6laFqN+3LK5ZV+zWkr//nKXZ8f2K3H2Ni55HMM0jAI/cqTJqEbc4haBfLnBWvEX+w1ERAP0rDtyCZLpRG08wOiM6amwrxygnAFN0JBlqVsSSPmEUiUT8YhiDP1vn6A8dveJnuSBwFJmAHmby0t8ow2icT0GEoYaCaafffs5iNUH3L17a8O26T2+rOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technica-engineering.de; dmarc=pass action=none
 header.from=technica-engineering.de; dkim=pass
 header.d=technica-engineering.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technicaengineering.onmicrosoft.com;
 s=selector2-technicaengineering-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1+OOfrq2ZFkE17nOEMInFlCm9KXaqZJ723AGsTLJ64=;
 b=Wzy9+xZYsW5vumh9dS4golcHTwJUO+2utB0s5HlYbH6rvJKVppOo5q05TGJqS78DcagZLeE73pq98cuTl60wUxeZ0Z0FoKoMlS/w8P/anzXQe1+gFizjUqdMZDF97kLB4mz1GI+2bKcN8McusLYzwprc9bEpZelaV+QSxNV1S20=
Received: from AM8PR08MB5698.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::24)
 by AM9PR08MB6866.eurprd08.prod.outlook.com (2603:10a6:20b:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 09:49:46 +0000
Received: from AM8PR08MB5698.eurprd08.prod.outlook.com
 ([fe80::a801:b98e:ad52:c8e4]) by AM8PR08MB5698.eurprd08.prod.outlook.com
 ([fe80::a801:b98e:ad52:c8e4%6]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 09:49:46 +0000
From:   Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
To:     "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: More flags for logging
Thread-Topic: More flags for logging
Thread-Index: AQHXQAN6B88UeDudRkC9a0XEdYmbM6rRiGkAgAF8UICAAAJ7woAAAHPggAAAc7A=
Date:   Tue, 4 May 2021 09:49:46 +0000
Message-ID: <AM8PR08MB5698052CEE5ABBD0B49D4A48B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>,<641804b4-733a-57b7-fdf1-b91293207f37@hartkopp.net>
 <DBBPR03MB7082C7E8FD22D0CA8C2DA99D9D5A9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <AM8PR08MB5698886555F8531B6CF65982B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
In-Reply-To: <AM8PR08MB5698886555F8531B6CF65982B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hartkopp.net; dkim=none (message not signed)
 header.d=none;hartkopp.net; dmarc=none action=none
 header.from=technica-engineering.de;
x-originating-ip: [62.216.206.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2d57ef0-0276-4c59-a516-08d90ee1f346
x-ms-traffictypediagnostic: AM9PR08MB6866:
x-microsoft-antispam-prvs: <AM9PR08MB68661FFC878F5E4E66EACC02B75A9@AM9PR08MB6866.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lk2a4qMy4ELK1BfPOewFLnLiyxnVf98YS201XMcBhBhi62XTlBIFtUw4WDAfIG+BJyw11tHuvw2TcLGEgI5TL7hZ6mca7dQ9t6MRrYAhOiP5FfEhiawgspxN7WzNR6QXS0GdRXvpC5L07CyFWdPkaiM8mMh9MzKTCgjY7IYdicWNgO/Ie+UnO2Ta9wrKLGq4H2PvcnzYWdR2O5vkye6nMDFhyrNjAuq7tpWCaSltIP812nf8QGed7sUXgttDP7jE3rVzl1CJIr2WpB1ZjaCXVAvrd+kRDt3Kwy8KKXZ+Y/UHsnMFbiYHKHKdeH+RfZmQe7MCwkg6McjOSkC+Iqr6nV44Hz/Fgrs6U9mY2/HnTfHTbXlRJg7QD8ZmO8lcImNjPIDXDkzZ5Rn12tTDiR0KcCOVfqm3PwGJI5aHnS8b8GfbTqcctCZzMeUPVlCfG/ewS7tLsAmlRGTgUYmDon2ugcSoUBvqY5BdA6AykRzIhrqZ0Hg2pT8r6+wfiSlVbkvzm5MqS9q4q0n0Wu+TiadjnGL08K6V7CpM9tdo3UNncefF7S2cf8LXWqPUdibUZVEuUIPiuhr5QCWatKcr+N6aj2sMIbKRYwYTm4ia7IRqmyfwKh60pMTSXHbqLlnAFusiCRO/Zpx90WwX+MhFSHDmhAiiSfbwC7t97xPY25cTqYysZDeW44CJooT0IpXB6Y8U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB5698.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39830400003)(136003)(376002)(366004)(71200400001)(38100700002)(52536014)(122000001)(3480700007)(966005)(2906002)(5660300002)(7696005)(6506007)(44832011)(478600001)(53546011)(64756008)(2940100002)(66446008)(83380400001)(9686003)(33656002)(66476007)(66556008)(86362001)(110136005)(66946007)(186003)(316002)(8936002)(76116006)(8676002)(26005)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?Rlg9KJlBpPwDH8YHg0rYIc5hYXbp2J72+yUFiCbssgMfe+7uw9IWseaJ?=
 =?Windows-1252?Q?D0kpL0NUy7xeZyiNqeMi2FmnOyQPe8FzTtw2uf0kFWP7yDEA1alhN9AJ?=
 =?Windows-1252?Q?rOursaYHej3pQ/ryvLr+mEVIKBfnz11mmY8wqQiYAWA65hOy0/vQeonp?=
 =?Windows-1252?Q?xO1QyNqbtjPmohR50VBQCPcX2TcJCiooQWzhJYkog2xXqfNnnabISncN?=
 =?Windows-1252?Q?G6MqlT5rWMLmjkOOlocLYpII/ykvwi/zmdmzhQPeM1pXDJgZF7ezAazx?=
 =?Windows-1252?Q?lVw4o27mJc8gaMv4jISaAU8j3yqXCCoq+//+gKUwikug/2n009UVxfEk?=
 =?Windows-1252?Q?d5qkDcheYkVtyLEnLi5WU2aamtTTeDHL3Wf/YbInc+6SoRDkQxugqyPO?=
 =?Windows-1252?Q?0QCh2bKmTkWa5gLgOwbkk3/4+Ka/15vT/kdf1zXLpjjT80qgcCKXqJcv?=
 =?Windows-1252?Q?M4pbDXePE0SrjQsbCfNhC/ful+VxsBZ7+Yo1I6UDsH3xU/EYaGeMXTEZ?=
 =?Windows-1252?Q?SUh5jQVjGQN8p66XIjgv3irRxyLRY6GRE3oWfFEHBLcBfeVV9cuow+/D?=
 =?Windows-1252?Q?31/DU5JU0NuCt6xd2Shy7t4bCgfyxOT7SgcJjmqI+52KZYVW+l+SVhNt?=
 =?Windows-1252?Q?rd5PoPFlSOwBPpHCdtp+N9UJnTKA7SkCKta2sgQ/A1EZmgUrlToUcHkS?=
 =?Windows-1252?Q?wMpvtdsrBo3zzXiN8/zfyWQclMS5DlbixgGTjWtmmGuLW928n9If2jcK?=
 =?Windows-1252?Q?sbKkgZCky08Zr8GqiywnEqNaeeR9surPjJpCFPJa8V4bqInR/tO3YVt7?=
 =?Windows-1252?Q?d2CWIvJvp62w/cM22rsP3it/EaN6yf2tk1U/rjs/EZ5hsFxW4Uo7mnTz?=
 =?Windows-1252?Q?hcdmhQp3Sr6r6vLYEsbtB3F8ZoQ/JFqOp7RnPl4X9aJU+nPK5xHdrDIe?=
 =?Windows-1252?Q?cqieAqWySVjIb9EkFa3GQQ7lUXz22J0rYWQ+Yb5pUFt8LFAkfbv+5Ttf?=
 =?Windows-1252?Q?Tl1YpxXFl/Dcc+xcvD9WQIc4StD4NdP7MkYzOfjah/6wlpmh51joiYzl?=
 =?Windows-1252?Q?70IIgcjKHMrhqDylRIxXsEt2k3E6aPMKGOZlmC34TDHtWTA6D++NoHv1?=
 =?Windows-1252?Q?A61W5k1ocFK/y72H5rhObzH9wPi4kjNCXvF3HU2bEZ3k4b0dk3HJL5US?=
 =?Windows-1252?Q?H246ZkUsXU+ZgtQjppyxqmwiseLydhrWWhLj0YPKGdXrANEl3Omy0f4+?=
 =?Windows-1252?Q?spjJXUyRJ/ZNBoxV/VmWK91r22XO1haxzLntk/tLiDpCOFD/2UIzJ9Ao?=
 =?Windows-1252?Q?4q+RGHb+NF2p1Lj7rU/6fOh4YpHocAZEqSU74pSvj2KBjWCUtXkirfZW?=
 =?Windows-1252?Q?GI5X30Te2j1QQwj8kWgA0vmE+cYS51am4EzcbMI0ZSOvxpcuk7ka1tsQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5698.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d57ef0-0276-4c59-a516-08d90ee1f346
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 09:49:46.0384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4QKzijwgmM23umL4pbPGgyYoWvymClyj+AklhXRbWANGxnJrAwf/X3f6LF4L64pOT+l+B1gnEB0Fp7LAE7rbxiZM+2kEvR3tTDGmFjgsH6ho7hb5hETiHaS8ShHRQpy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6866
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

(I changed the email I use, since the old one did not support sending plain=
 text emails.)

There seems to be a mis-conception about how WireShark/Libpcap handle Socke=
tCAN:

There is no ethertype involved, the data of the frame will directly start w=
ith the CAN ID.

The socket CAN in PCAP format pre-date CAN-FD (Developed in 2011), so at th=
e time, there was only "CAN" (Introduced in Oct, 2009).
See https://github.com/the-tcpdump-group/libpcap/commit/86ed15cc8b4bd7dc145=
8559108e66a07ec6721ec
The introduction of CAN-FD later on did not change that.

Libpcap library maps both LINUX_SLL_P_CAN and LINUX_SLL_P_CANFD (they are t=
reated identically the same way) to DLT_CAN_SOCKETCAN and copy bytes as is =
(the only change is changing the endianness if ID if needed).

The MTU solution still not does provide a fix for the case of a normal CAN =
message being transported over a CAN-FD bus.
In this case, application cannot tell if frame was physically transported a=
s CAN or CAN-FD.
See https://noelscher.com/blog/posts/compatibility-of-can-and-can-fd/

Best Regards.

Ayoub Kaanich.

-----Original Message-----

From: mailto:socketcan@hartkopp.net
Sent: Tuesday, May 4, 2021 10:49 AM
To: mailto:mkl@pengutronix.de; mailto:linux-can@vger.kernel.org
Cc: mailto:kayoub5@live.com
Subject: Re: More flags for logging



On 03.05.21 12:08, Marc Kleine-Budde wrote:
> On 03.05.2021 12:02:46, Marc Kleine-Budde wrote:
>> The SocketCAN API is a great initiative for standardizing the CAN=20
>> interface API. This request tries to extend this initiative for more=20
>> use cases.
>>
>> Context:
>>
>> The SocketCAN was adopted by libpcap and tcpdump as the standard=20
>> format for logging CAN Frames in PCAP and PCAP-NG. See:
>>
>> https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html
>> https://github.com/wireshark/wireshark/blob/master/epan/dissectors/pa
>> cket-socketcan.c https://www.wireshark.org/docs/dfref/c/can.html
>>
>> Problem:
>> Applications that perform logging, usually need more details that=20
>> normal applications, for the sake of debugging later on. Flags needs=20
>> to be reserved/allocated in the SocketCAN API, so that logging=20
>> applications can make use of them in the PCAP format. The flags does=20
>> not need necessary need to be implemented by SocketCAN, they just=20
>> need to be marked as reserved for such use case.
>>
>> Needed Flags:
>> FDF Flag
>> - Since CAN Frames and CAN-FD frames can co-exist in the same bus,
>>=A0=A0=A0 logging application needs to know if a normal CAN Frame was
>>=A0=A0=A0 transmitted on a CAN-FD bus, namely was the FDF bit set or not.
>=20
> I think someone asked for that some time ago. But that was never=20
> mainlined. I'll look for that old mail.
>=20

When you display CAN and CAN FD frames in Wireshark they are displayed as d=
ifferent "protocols" - as they also have different ethtypes.

So the difference is provided by the 'protocol' field. Or did I miss someth=
ing?

Regards,
Oliver

>> ACK bit in data frame
>> - Some logging hardware can act as a "spy", meaning that it records=20
>>CAN
>>=A0=A0=A0 Frames, but does not set the ACK bit
>> - A way to know for a given frame (FD or not), was the ACK bit set or
>>=A0=A0=A0 not.
>> - Current API allow detecting missing ACK, but it does not report=20
>>what
>>=A0=A0=A0 Frame had a missing ACK.
>=20
> This means the driver has to set a flag if it's configured in=20
> listen-only mode. That should be possible.
>=20
> I think we can make use of flags in the struct canfd_frame for this:
>=20
> | struct canfd_frame {
> |=A0=A0=A0=A0=A0 canid_t can_id;=A0 /* 32 bit CAN_ID + EFF/RTR/ERR flags =
*/
> |=A0=A0=A0=A0=A0 __u8=A0=A0=A0 len;=A0=A0=A0=A0 /* frame payload length i=
n byte */
> |=A0=A0=A0=A0=A0 __u8=A0=A0=A0 flags;=A0=A0 /* additional flags for CAN F=
D */
> |=A0=A0=A0=A0=A0 __u8=A0=A0=A0 __res0;=A0 /* reserved / padding */
> |=A0=A0=A0=A0=A0 __u8=A0=A0=A0 __res1;=A0 /* reserved / padding */
> |=A0=A0=A0=A0=A0 __u8=A0=A0=A0 data[CANFD_MAX_DLEN] __attribute__((aligne=
d(8)));  };
>=20
> The struct can_frame doesn't have the flags member yet, but we can add=20
> it there.
>=20
> regards,
> Marc
>=20

